/**
   Copyright [2013-2018] [plter] http://plter.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

package com.plter.lib.java.lang;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


/**
 * 对象池
 * @author xtiqin
 *
 */
public class ObjectPool {
	
	
	private static final Map<Class<?>, ArrayList<Object>> classMap=new HashMap<Class<?>, ArrayList<Object>>();
	
	private static ArrayList<Object> tmpArr=null;
	
	
	/**
	 * 取得指定对象的实例
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T get(Class<T> clazz){
		try {
			if (classMap.containsKey(clazz)) {
				tmpArr=classMap.get(clazz);
				if (tmpArr.size()>0) {
					return (T)tmpArr.remove(0);
				}
			}
			
			return (T)clazz.newInstance();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	/**
	 * 回收一个对象
	 * @param obj
	 */
	public static void recycle(Object obj){
		if (classMap.containsKey(obj.getClass())) {
			tmpArr=classMap.get(obj.getClass());
			if (!tmpArr.contains(obj)) {
				tmpArr.add(obj);
			}
		}else{
			tmpArr=new ArrayList<Object>();
			tmpArr.add(obj);
			classMap.put(obj.getClass(), tmpArr);
		}
	}
	
	public static void clear(){
		classMap.clear();
	}


}
