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

   This is a part of PlterAndroidLib on 
   http://plter.sinaapp.com/?cat=14 
	https://github.com/xtiqin/plter-android-lib
 */

package com.plter.lib.java.event;


public class Event extends com.plter.lib.java.lang.PObject{

	public Event init(String name,Object data) {
		setName(name);
		setData(data);
		reset();
		return this;
	}
	
	public Event init(String name){
		setName(name);
		reset();
		return this;
	}
	
	public String getName() {
		return name;
	}
	
	private void setName(String name) {
		this.name = name;
	}


	public Object getData() {
		return data;
	}


	private void setData(Object data) {
		this.data = data;
	}
	
	/**
	 * 停止对所有后续侦听器事件的触发
	 */
	public void stop(){
		stoped=true;
	}
	
	public Event clone(){
		return alloc(Event.class).init(getName(), getData());
	}


	public boolean isStoped() {
		return stoped;
	}

	/**
	 * 重置事件相关属性
	 */
	void reset() {
		stoped=false;
	}
	
	@Override
	public void recycle() {
		setName(null);
		setData(null);
		reset();
		super.recycle();
	}

	private String name=null;
	private Object data=null;
	private boolean stoped=false;
	
}
