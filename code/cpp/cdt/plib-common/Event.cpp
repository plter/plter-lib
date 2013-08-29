/*
 * Event.cpp
 *
 *      Author: plter
 */

#include "Event.h"

namespace plter {

Event::Event():Object() {
	_data = NULL;
	_name = "";
}

Event::Event(string name):Object(){
	setName(name);
    
    _data = NULL;
}

Event::Event(string name,Object* data):Object(){
    _data = NULL;
    
	setName(name);
	setData(data);
}

Event::Event(Object* data):Object(){
	setData(data);

	_name = "";
}

string Event::getName(){
	return _name;
}

Object* Event::getData(){
	return _data;
}

void Event::setData(Object* data) {
    if (_data!=NULL) {
        _data->release();
    }
    
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

void Event::setName(string name) {
	_name = name;
}

} /* namespace plter */

