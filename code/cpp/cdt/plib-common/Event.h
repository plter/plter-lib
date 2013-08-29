/*
 * Event.h
 *
 *      Author: plter
 */

#ifndef EVENT_H_
#define EVENT_H_

#include <string>
#include "Object.h"

using namespace std;


namespace plter {

class Event :public Object{
public:
	Event();
	Event(string type);
	Event(string type,Object* data);
	Event(Object* data);
	virtual string getName();
	virtual Object* getData();
	virtual ~Event();

private:
	string _name;
	Object* _data;
	virtual void setData(Object* data);
	virtual void setName(string type);
};

} /* namespace plter */
#endif /* EVENT_H_ */
