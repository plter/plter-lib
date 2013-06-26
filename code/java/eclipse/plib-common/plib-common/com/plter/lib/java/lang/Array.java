package com.plter.lib.java.lang;

/**
 * 该数组使用链表实现，高效、安全
 * @author plter
 *
 * @param <T>
 */
public class Array<T> {


	public Array() {
		clear();
	}

	
	/**
	 * 遍历数组的每一个元素
	 * @param loopCallback
	 */
	public final void each(ArrayLoopCallback<T> loopCallback){
		Item<T> tmp = _begin;
		
		while(tmp.nextItem!=_end){
			tmp = tmp.nextItem;
			loopCallback.onRead(tmp.value);
			
			if (loopCallback.isBreaked()) {
				break;
			}
		}
	}

	/**
	 * 根据索引获取一项
	 * @param index
	 * @return
	 */
	public final T get(int index){
		Item<T> i = getItem(index);
		return i!=null?i.value:null;
	}
	
	/**
	 * 判断数组中是否包含某项
	 * @param obj
	 * @return
	 */
	public final boolean contains(T obj){
		return indexOf(obj)>-1;
	}
	

	/**
	 * 获取某项所在的索引
	 * @param obj
	 * @return
	 */
	public final int indexOf(T obj){
		
		Item<T> tmp = _begin;
		
		for (int i = 0; i < length(); i++) {
			tmp = tmp.nextItem;
			
			if (tmp.value==obj) {
				return i;
			}
		}
		
		return -1;
	}
	
	/**
	 * 添加一项
	 * @param obj
	 * @return
	 */
	public final T push(T obj){
		addItemBefore(new Item<T>(obj), _end);
		return obj;
	}

	/**
	 * 插入一项
	 * @param obj
	 * @param index
	 * @return
	 */
	public final T insert(T obj,int index){
		Item<T> tmp = getItem(index);
		if (tmp!=null) {
			Item<T> itemToAdd = new Item<T>(obj);
			addItemBefore(itemToAdd, tmp);
			return obj;
		}
		return null;
	}
	
	
	/**
	 * 删除最后一项
	 * @return
	 */
	public final T pop(){
		Item<T> tmp = _end.preItem;
		removeItem(tmp);
		return tmp.value;
	}
	
	
	/**
	 * 删除第一项
	 * @return
	 */
	public final T shift(){
		Item<T> tmp = _begin.nextItem;
		removeItem(tmp);
		return tmp.value;
	}

	/**
	 * 删除其中一项
	 * @param obj
	 * @return
	 */
	public final T remove(T obj){
		
		Item<T> tmp = _begin;
		
		while(tmp.nextItem!=null){
			tmp = tmp.nextItem;
			if (tmp.value==obj) {
				removeItem(tmp);
				return obj;
			}
		}
		
		return null;
	}

	/**
	 * 删除指定索引处的该项
	 * @param index
	 * @return
	 */
	public final T remove(int index){
		Item<T> i = getItem(index);
		if (i!=null) {
			removeItem(i);
			return i.value;
		}
		return null;
	}

	public final void clear(){
		_begin.nextItem = _end;
		_end.preItem = _begin;
		_length = 0;
	}

	public final int length(){
		return _length;
	}
	
	private void removeItem(Item<T> item){
		item.nextItem.preItem = item.preItem;
		item.preItem.nextItem = item.nextItem;
		_length--;
	}

	private void addItemBefore(Item<T> itemToAdd,Item<T> item){
		itemToAdd.nextItem = item;
		itemToAdd.preItem = item.preItem;
		itemToAdd.preItem.nextItem = itemToAdd;
		itemToAdd.nextItem.preItem = itemToAdd;
		_length++;
	}
	
	private Item<T> getItem(int index){
		
		if (index>=length()||index<0) {
			return null;
		}
		
		Item<T> tmp = null;
		
		if (index<length()/2) {
			tmp = _begin;
			for (int i = 0; i <= index; i++) {
				tmp = tmp.nextItem;
			}
		}else{
			tmp = _end;
			for (int i = length(); i > index; i--) {
				tmp = tmp.preItem;
			}
		}
		
		return tmp;
	}

	private int _length = 0;
	private final Item<T> _begin = new Item<T>(null);
	private final Item<T> _end = new Item<T>(null);

	
	private final static class Item<ValueType>{
		
		public Item(ValueType value) {
			this.value = value;
		}
		
		public ValueType value=null;
		public Item<ValueType> preItem = null;
		public Item<ValueType> nextItem = null;
	}
}
