/*
 * Event.cpp
 *
 *      Author: plter
 */

#include "Event.h"

namespace plter {

Event::Event(string type):Object(){
	setType(type);
	setData(NULL);
}

Event::Event(string type,Object* data):Object(){
	setType(type);
	setData(data);
}

Event::Event(Object* data):Object(){
	setData(data);
}

string Event::getType(){
	return _type;
}

Object* Event::getData(){
	return _data;
}

void Event::setData(Object* data) {
	_data = data;
	if (_data!=NULL) {
		_data->retain();
	}
}

Event::~Event() {
	if (_data!=NULL) {
		_data->release();
	}
}

void Event::setType(string type) {
	_type = type;
}

} /* namespace plter */
