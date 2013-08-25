/*
 * EventListener.h
 *
 *  Created on: 2013年8月25日
 *      Author: plter
 */

#ifndef EVENTLISTENER_H_
#define EVENTLISTENER_H_

#include "Event.h"

namespace plter {

class EventListener {
public:
	EventListener();
	virtual bool execute(Event* e,void* target)=0;
	virtual ~EventListener();
};

} /* namespace plter */
#endif /* EVENTLISTENER_H_ */
