/**
   Copyright [plter] [xtiqin]
   http://plter.sinaapp.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

   This is a part of plter-lib on 
	https://github.com/plter/plter-lib
 */

package com.plter.lib.java.event;

import com.plter.lib.java.lang.Array;
import com.plter.lib.java.lang.ArrayIterator;

public class EventListenerList<E extends Event> {

	public void add(EventListener<E> listener){
		eList.push(listener);
	}
	
	public void add(EventListener<E> listener,int index){
		eList.insert(listener, index);
	}
	
	public void remove(EventListener<E> listener){
		eList.remove(listener);
	}
	
	public void remove(){
		eList.clear();
	}
	
	
	private boolean _dispatchSuc = true;
	public boolean dispatch(final Object target,final E event){
		
		_dispatchSuc = true;
		
		ArrayIterator<EventListener<E>> current = eList.begin().nextItem();
		while(current!=eList.end()){
			
			if (!current.value().onReceive(target, event)) {
				_dispatchSuc=false;
			}
			
			if (event.isStoped()) {
				event.reset();
				break;
			}
			
			current = current.nextItem();
		}
		
		event.recycle();
		return _dispatchSuc;
	}
	
	
	public boolean dispatch(E event){
		return dispatch(null,event );
	}
	
	private final Array<EventListener<E>> eList = new Array<EventListener<E>>();
	
}
