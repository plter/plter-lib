package com.plter.utils.zip {
	
	import flash.errors.IOError;
	
	/**
	 * Thrown during the creation or input of a zip file.
	 */
	public class ZipError extends IOError {
		
		public function ZipError(message:String = "", id:int = 0) {
			super(message, id);
		}
		
	}
	
}
