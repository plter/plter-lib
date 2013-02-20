package com.plter.utils.zip
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;

	/**
	 * 用于读取zip文件
	 * @author Jaja plter.com
	 */
	public class ZipDecoder
	{
		private var _names:Vector.<String>=new Vector.<String>;
		private var buf:ByteArray; // data from which zip entries are read.
		private var entryList:Vector.<ZipEntry>;
		private var entryTable:Dictionary;
		private var locOffsetTable:Dictionary;

		public function ZipDecoder(bytes:ByteArray):void
		{
			buf=new ByteArray();
			buf.endian=Endian.LITTLE_ENDIAN;
			bytes.readBytes(buf);
			readEntries();

			for (var i:int=0; i < entries.length; i++)
			{
				_names.push(entries[i].path);
			}
		}

		/**
		 * 获得zip文件中的文件名称数组
		 * @return
		 */
		public function get names():Vector.<String>
		{
			return _names;
		}

		/**
		 * 通过文件名称获得文件的数据字节数组
		 * @param	name
		 * @return
		 */
		public function getFile(name:String):ByteArray
		{
			return getInput(getEntry(name));
		}

		/**
		 * 获得所有zip中文件头信息
		 */
		public function get entries():Vector.<ZipEntry>
		{
			return entryList;
		}

		/**
		 * 获得zip中文件的个数
		 */
		public function get size():uint
		{
			return entryList.length;
		}


		/**
		 * 根据路径获得zip中文件信息
		 * @param path	文件的路径，如：dir/file.txt
		 * @return
		 */
		public function getEntry(path:String):ZipEntry
		{
			return entryTable[path];
		}


		/**
		 * 根据文件头信息获得文件数据
		 * @param entry	文件头信息
		 * @return
		 */
		public function getInput(entry:ZipEntry):ByteArray
		{
			// extra field for local file header may not match one in central directory header
			buf.position=locOffsetTable[entry.path] + ZipConstants.LOCHDR - 2;
			var len:uint=buf.readShort(); // extra length

			var nameBytes:ByteArray=new ByteArray;
			nameBytes.writeMultiByte(entry.path, "GBK");

			buf.position+=nameBytes.length + len;
			var b1:ByteArray=new ByteArray();
			// read compressed data
			if (entry.compressedSize > 0)
				buf.readBytes(b1, 0, entry.compressedSize);
			switch (entry.method)
			{
				case ZipConstants.STORED:
					return b1;
					break;
				case ZipConstants.DEFLATED:
					/*
					   if(Security.sandboxType == Security.APPLICATION) {
					   // apollo environment
					   b1.inflate();
					   return b1;
					   }
					 /**/
					var b2:ByteArray=new ByteArray();
					var inflater:Inflater=new Inflater();
					inflater.setInput(b1);
					inflater.inflate(b2);
					return b2;
					break;
				default:
					throw new ZipError("invalid compression method");
			}
			return null;
		}

		/**
		 * Read the central directory of a zip file and fill the entries
		 * array.  This is called exactly once when first needed.
		 */
		private function readEntries():void
		{
			readEND();
			entryTable=new Dictionary();
			locOffsetTable=new Dictionary();
			// read cen entries
			for (var i:uint=0; i < entryList.length; i++)
			{
				var tmpbuf:ByteArray=new ByteArray();
				tmpbuf.endian=Endian.LITTLE_ENDIAN;
				buf.readBytes(tmpbuf, 0, ZipConstants.CENHDR);
				if (tmpbuf.readUnsignedInt() != ZipConstants.CENSIG)
					throw new ZipError("invalid CEN header (bad signature)");
				// handle filename
				tmpbuf.position=ZipConstants.CENNAM;
				var len:uint=tmpbuf.readUnsignedShort();
				if (len == 0)
					throw new ZipError("missing entry name");
				var e:ZipEntry=new ZipEntry(buf.readMultiByte(len, "GBK"));
				// handle extra field
				len=tmpbuf.readUnsignedShort();
				e.extra=new ByteArray();
				if (len > 0)
					buf.readBytes(e.extra, 0, len);
				// handle file comment
				buf.position+=tmpbuf.readUnsignedShort();
				// now get the remaining fields for the entry
				tmpbuf.position=ZipConstants.CENVER;
				e.version=tmpbuf.readUnsignedShort();
				e.flag=tmpbuf.readUnsignedShort();
				if ((e.flag & 1) == 1)
					throw new ZipError("encrypted ZIP entry not supported");
				e.method=tmpbuf.readUnsignedShort();
				e.dostime=tmpbuf.readUnsignedInt();
				e.crc=tmpbuf.readUnsignedInt();
				e.compressedSize=tmpbuf.readUnsignedInt();
				e.size=tmpbuf.readUnsignedInt();
				// add to entries and table
				entryList[i]=e;
				entryTable[e.path]=e;
				// loc offset
				tmpbuf.position=ZipConstants.CENOFF;
				locOffsetTable[e.path]=tmpbuf.readUnsignedInt();
			}
		}

		/**
		 * Reads the total number of entries in the central dir and
		 * positions buf at the start of the central directory.
		 */
		private function readEND():void
		{
			var b:ByteArray=new ByteArray();
			b.endian=Endian.LITTLE_ENDIAN;
			buf.position=findEND();
			buf.readBytes(b, 0, ZipConstants.ENDHDR);
			b.position=ZipConstants.ENDTOT;
			entryList=new Vector.<ZipEntry>(b.readUnsignedShort());
			b.position=ZipConstants.ENDOFF;
			buf.position=b.readUnsignedInt();
		}

		private function findEND():uint
		{
			var i:uint=buf.length - ZipConstants.ENDHDR;
			var n:uint=Math.max(0, i - 0xffff); // 0xffff is max zip file comment length
			// TODO: issue when n is 0 and ENDSIG not found (since variable i cannot be negative)
			for (i; i >= n; i--)
			{
				if (buf[i] != 0x50)
					continue; // quick check that the byte is 'P'
				buf.position=i;
				if (buf.readUnsignedInt() == ZipConstants.ENDSIG)
					return i;
			}
			throw new ZipError("invalid zip");
			return 0;
		}

	}

}