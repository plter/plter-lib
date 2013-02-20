package com.plter.utils.zip
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;

	/**
	 * 该类用于创建zip文件
	 * @author Jaja plter.com
	 */
	public class ZipEncoder
	{
		private var _entry:ZipEntry;
		private var _entries:Vector.<ZipEntry>=new Vector.<ZipEntry>;
		private var _names:Dictionary=new Dictionary();
		private var _def:Deflater=new Deflater();
		private var _crc:CRC32=new CRC32();
		private var _buf:ByteArray=new ByteArray();
		private var _comment:String="";

		public function ZipEncoder()
		{
			_buf.endian=Endian.LITTLE_ENDIAN;
		}

		/**
		 * 向zip文件中添加一个文件
		 * @param	path 要添加的文件的路径,如:test.txt,package/test.txt
		 * @param	bytes 要添加的文件的二进制数据
		 */
		public function addFile(path:String, bytes:ByteArray):void
		{
			var entry:ZipEntry=new ZipEntry(path);
			putNextEntry(entry);
			write(bytes);
		}

		/**
		 * 获得zip文件中文件的个数
		 */
		public function get size():uint
		{
			return _entries.length;
		}

		/**
		 * 获得创建的zip文件的二进制数据
		 */
		public function get byteArray():ByteArray
		{
			_buf.position=0;
			return _buf;
		}

		/**
		 *设置zip文件说明
		 */
		public function setComment(value:String):void
		{
			_comment=value;
		}

		/**
		 * zip文件创建完毕
		 */
		public function finish():void
		{
			if (_entry != null)
				closeEntry();
			if (_entries.length < 1)
				throw new ZipError("ZIP file must have at least one entry");
			var off:uint=_buf.position;
			// write central directory
			for (var i:uint=0; i < _entries.length; i++)
			{
				writeCEN(_entries[i]);
			}
			writeEND(off, _buf.position - off);
		}

		/**
		 * 添加下一个子文件信息
		 * @param	e 子文件描述
		 */
		private function putNextEntry(e:ZipEntry):void
		{
			if (_entry != null)
				closeEntry();
			// TODO:
			if (e.dostime == 0)
				e.time=new Date().time;
			if (e.method == -1)
				e.method=ZipConstants.DEFLATED; // use default method
			switch (e.method)
			{
				case ZipConstants.DEFLATED:
					if (e.size == -1 || e.compressedSize == -1 || e.crc == 0)
					{
						// store size, compressed size, and crc-32 in data descriptor
						// immediately following the compressed entry data
						e.flag=8;
					}
					else if (e.size != -1 && e.compressedSize != -1 && e.crc != 0)
					{
						// store size, compressed size, and crc-32 in LOC header
						e.flag=0;
					}
					else
					{
						throw new ZipError("DEFLATED entry missing size, compressed size, or crc-32");
					}
					e.version=20;
					break;
				case ZipConstants.STORED:
					// compressed size, uncompressed size, and crc-32 must all be
					// set for entries using STORED compression method
					if (e.size == -1)
					{
						e.size=e.compressedSize;
					}
					else if (e.compressedSize == -1)
					{
						e.compressedSize=e.size;
					}
					else if (e.size != e.compressedSize)
					{
						throw new ZipError("STORED entry where compressed != uncompressed size");
					}
					if (e.size == -1 || e.crc == 0)
					{
						throw new ZipError("STORED entry missing size, compressed size, or crc-32");
					}
					e.version=10;
					e.flag=0;
					break;
				default:
					throw new ZipError("unsupported compression method");
			}
			e.offset=_buf.position;
			if (_names[e.path] != null)
			{
				throw new ZipError("duplicate entry: " + e.path);
			}
			else
			{
				_names[e.path]=e;
			}
			writeLOC(e);
			_entries.push(e);
			_entry=e;
		}

		/**
		 * 为当前子文件描述添加二进制数据
		 * @param	b 包括文件数据的字节数组
		 */
		private function write(b:ByteArray):void
		{
			if (_entry == null)
			{
				throw new ZipError("no current ZIP entry");
			}
			//*
			switch (_entry.method)
			{
				case ZipConstants.DEFLATED:
					//super.write(b, off, len);
					var cb:ByteArray=new ByteArray();
					_def.setInput(b);
					_def.deflate(cb);
					_buf.writeBytes(cb);
					// TODO: test if Deflater can deflate to the end of _buf (saves from using variable cb and an extra copy)
					break;
				case ZipConstants.STORED:
					// TODO:
					//if (written - locoff > _entry.size) {
					//	throw new ZipError("attempt to write past end of STORED entry");
					//}
					//out.write(b, off, len);
					_buf.writeBytes(b);
					break;
				default:
					throw new Error("invalid compression method");
			}
			/**/
			_crc.update(b);
		}

		// check if this method is still necessary since we're not dealing with streams
		// seems crc and whether a data descriptor i necessary is determined here
		private function closeEntry():void
		{
			var e:ZipEntry=_entry;
			if (e != null)
			{
				switch (e.method)
				{
					case ZipConstants.DEFLATED:
						if ((e.flag & 8) == 0)
						{
							// verify size, compressed size, and crc-32 settings
							if (e.size != _def.getBytesRead())
							{
								throw new ZipError("invalid entry size (expected " + e.size + " but got " + _def.getBytesRead() + " bytes)");
							}
							if (e.compressedSize != _def.getBytesWritten())
							{
								throw new ZipError("invalid entry compressed size (expected " + e.compressedSize + " but got " + _def.getBytesWritten() + " bytes)");
							}
							if (e.crc != _crc.getValue())
							{
								throw new ZipError("invalid entry CRC-32 (expected 0x" + e.crc + " but got 0x" + _crc.getValue() + ")");
							}
						}
						else
						{
							e.size=_def.getBytesRead();
							e.compressedSize=_def.getBytesWritten();
							e.crc=_crc.getValue();
							writeEXT(e);
						}
						_def.reset();
						break;
					case ZipConstants.STORED:
						// TODO:
						break;
					default:
						throw new Error("invalid compression method");
				}
				_crc.reset();
				_entry=null;
			}
		}

		private function writeLOC(e:ZipEntry):void
		{
			var nameBytes:ByteArray=new ByteArray;
			nameBytes.writeMultiByte(e.path, "GBK");

			_buf.writeUnsignedInt(ZipConstants.LOCSIG);
			_buf.writeShort(e.version);
			_buf.writeShort(e.flag);
			_buf.writeShort(e.method);
			_buf.writeUnsignedInt(e.dostime); // dostime
			if ((e.flag & 8) == 8)
			{
				// store size, uncompressed size, and crc-32 in data descriptor
				// immediately following compressed entry data
				_buf.writeUnsignedInt(0);
				_buf.writeUnsignedInt(0);
				_buf.writeUnsignedInt(0);
			}
			else
			{
				_buf.writeUnsignedInt(e.crc); // crc-32
				_buf.writeUnsignedInt(e.compressedSize); // compressed size
				_buf.writeUnsignedInt(e.size); // uncompressed size
			}

			_buf.writeShort(nameBytes.length);
			_buf.writeShort(e.extra != null ? e.extra.length : 0);
			_buf.writeBytes(nameBytes);
			if (e.extra != null)
			{
				_buf.writeBytes(e.extra);
			}
		}

		/*
		 * Writes extra data descriptor (EXT) for specified entry.
		 */
		private function writeEXT(e:ZipEntry):void
		{
			_buf.writeUnsignedInt(ZipConstants.EXTSIG); // EXT header signature
			_buf.writeUnsignedInt(e.crc); // crc-32
			_buf.writeUnsignedInt(e.compressedSize); // compressed size
			_buf.writeUnsignedInt(e.size); // uncompressed size
		}

		/*
		 * Write central directory (CEN) header for specified entry.
		 * REMIND: add support for file attributes
		 */
		private function writeCEN(e:ZipEntry):void
		{
			var nameBytes:ByteArray=new ByteArray;
			nameBytes.writeMultiByte(e.path, "GBK");
			var ecommentBytes:ByteArray=new ByteArray;
			ecommentBytes.writeMultiByte(e.comment, "GBK");

			_buf.writeUnsignedInt(ZipConstants.CENSIG); // CEN header signature
			_buf.writeShort(e.version); // version made by
			_buf.writeShort(e.version); // version needed to extract
			_buf.writeShort(e.flag); // general purpose bit flag
			_buf.writeShort(e.method); // compression method
			_buf.writeUnsignedInt(e.dostime); // last modification time
			_buf.writeUnsignedInt(e.crc); // crc-32
			_buf.writeUnsignedInt(e.compressedSize); // compressed size
			_buf.writeUnsignedInt(e.size); // uncompressed size
			_buf.writeShort(nameBytes.length);
			_buf.writeShort(e.extra != null ? e.extra.length : 0);
			_buf.writeShort(ecommentBytes.length);
			_buf.writeShort(0); // starting disk number
			_buf.writeShort(0); // internal file attributes (unused)
			_buf.writeUnsignedInt(0); // external file attributes (unused)
			_buf.writeUnsignedInt(e.offset); // relative offset of local header
			_buf.writeBytes(nameBytes);
			if (e.extra != null)
			{
				_buf.writeBytes(e.extra);
			}
			if (e.comment != null)
			{
				_buf.writeBytes(ecommentBytes);
			}
		}

		/*
		 * Writes end of central directory (END) header.
		 */
		private function writeEND(off:uint, len:uint):void
		{
			_buf.writeUnsignedInt(ZipConstants.ENDSIG); // END record signature
			_buf.writeShort(0); // number of this disk
			_buf.writeShort(0); // central directory start disk
			_buf.writeShort(_entries.length); // number of directory entries on disk
			_buf.writeShort(_entries.length); // total number of directory entries
			_buf.writeUnsignedInt(len); // length of central directory
			_buf.writeUnsignedInt(off); // offset of central directory

			var commentBytes:ByteArray=new ByteArray;
			commentBytes.writeMultiByte(_comment, "GBK");

			_buf.writeShort(commentBytes.length);
			_buf.writeBytes(commentBytes); // zip file comment
		}

	}

}