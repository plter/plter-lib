package com.plter.utils
{
	import flash.utils.getQualifiedClassName;

	public class ObjectUtil
	{
		/**
		 * Convert a untyped amf object to XML object
		 * @param obj
		 * @param name	The XML's name
		 * @return 
		 */		
		public static function untypedObjectToXML(obj:Object,name:String="data"):XML{
			var xml:XML=XML("<"+name+"></"+name+">");
			addValueToXML(xml,obj);
			return xml;
		}
		
		/**
		 * Add a value to an XML or XMLList Object
		 * @param xml	type of XML or XMLList
		 * @param obj
		 */
		private static function addValueToXML(xml:*,obj:*):void{
			var xmlType:String=getQualifiedClassName(xml);
			var objType:String=getQualifiedClassName(obj);
			
			if(xmlType!="XML"&&xmlType!="XMLList"){
				throw new Error("Param xml must be an XML or XMLList object");
			}
			if(xmlType=="XML"&&objType!="Object"){
				throw new Error("If xml is an XML object,the obj must be an Object object");
			}
			if(xmlType=="XMLList"&&objType!="Array"){
				throw new Error("If xml is an XMLList object,the obj must be an Array object");
			}
			
			var subXML:*;
			var value:Object;
			switch(objType){
				case "Object":
					for(var i:String in obj){
						value=obj[i];
						switch(getQualifiedClassName(value)){
							case "Object":
								subXML=XML("<"+i+"></"+i+">");
								addValueToXML(subXML,value);
								xml.appendChild(subXML);
								break;
							case "Array":
								subXML=XMLList("<"+i+"></"+i+">");
								addValueToXML(subXML,value);
								xml.appendChild(subXML);
								break;
							default:
								xml.appendChild(XMLList("<"+i+">"+value+"</"+i+">"));
						}
					}
					break;
				case "Array":
					for(var j:String in obj){
						value=obj[j];
						switch(getQualifiedClassName(value)){
							case "Object":
								subXML=XML("<"+xml[0].localName()+"></"+xml[0].localName()+">");
								addValueToXML(subXML,value);
								xml[j]=subXML;
								break;
							default:
								xml[j]=value;
						}
					}
					break;
			}
			
		}
		
		
		/**
		 * Convert an XML object to a untyped amf object
		 * @param xml
		 * @return Object
		 */
		public static function xmlToUntypedObject(xml:XML):Object{
			var obj:Object={};
			addXMLToObject(obj,xml);
			return obj;
		}
		
		
		/**
		 * Add an XML object or XMLList object to an Object
		 * @param obj
		 * @param xml	An XML object or XMLList object
		 */
		private static function addXMLToObject(obj:*,xml:*):void{
			var xmlType:String=getQualifiedClassName(xml);
			var objType:String=getQualifiedClassName(obj);
			
			if(xmlType!="XML"&&xmlType!="XMLList"){
				throw new Error("Param xml must be an XML or XMLList object");
			}
			
			
		}
	}
}