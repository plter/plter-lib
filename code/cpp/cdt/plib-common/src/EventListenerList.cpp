/*
 * EventListenerList.cpp
 *
 *  Created on: 2013年8月25日
 *      Author: plter
 */

#include "EventListenerList.h"

namespace plter {

EventListenerList::EventListenerList() {
	// TODO Auto-generated constructor stub

}


EventListener* EventListenerList::addListener(EventListener* el){
	_els.push_back(el);
	return el;
}

EventListener* EventListenerList::removeListener(EventListener* el){
	for(vector<EventListener*>::iterator it = _els.begin();it!=_els.end();++it){
		if (el==*it) {
			_els.erase(it);
			break;
		}
	}
	return el;
}

bool EventListenerList::dispatch(Event* e,void* target){
	bool suc = true;
	for(vector<EventListener*>::iterator it = _els.begin();it!=_els.end();++it){
		if (!((EventListener*)(*it))->execute(e,target)) {
			suc = false;
		}
	}
	return suc;
}

bool EventListenerList::dispatch(Event* e){
	return dispatch(e,NULL);
}


EventListenerList::~EventListenerList() {
	// TODO Auto-generated destructor stub
}

} /* namespace plter */
