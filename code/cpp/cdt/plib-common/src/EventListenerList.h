/*
 * EventListenerList.h
 *
 *  Created on: 2013年8月25日
 *      Author: plter
 */

#ifndef EVENTLISTENERLIST_H_
#define EVENTLISTENERLIST_H_

#include "EventListener.h"
#include "Event.h"
#include <vector>

using namespace std;

namespace plter {

class EventListenerList {
public:
	EventListenerList();
	virtual EventListener* addListener(EventListener* el);
	virtual EventListener* removeListener(EventListener* el);
	virtual bool dispatch(Event* e);
	virtual bool dispatch(Event* e,void* target);
	virtual ~EventListenerList();

private:
	vector<EventListener*> _els;
};

} /* namespace plter */
#endif /* EVENTLISTENERLIST_H_ */
