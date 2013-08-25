/*
 * Event.h
 *
 *  Created on: 2013年8月25日
 *      Author: plter
 */

#ifndef EVENT_H_
#define EVENT_H_

#include <string>

using namespace std;


namespace plter {

class Event {
public:
	Event();
	Event(string type);
	Event(string type,void* data);
	Event(void* data);
	virtual string getType();
	virtual void* getData();
	virtual ~Event();

private:
	string _type;
	void* _data;
};

} /* namespace plter */
#endif /* EVENT_H_ */
