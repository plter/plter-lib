package com.plter.lib.java.lang;


public final class ArrayIterator<ValueType>{
	
	public ArrayIterator(ValueType value) {
		this.value = value;
	}
	
	public ValueType value=null;
	public ArrayIterator<ValueType> preItem = null;
	public ArrayIterator<ValueType> nextItem = null;
}