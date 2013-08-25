/*
 * Event.cpp
 *
 *  Created on: 2013年8月25日
 *      Author: plter
 */

#include "Event.h"

namespace plter {

Event::Event() {
	_data = NULL;
}

Event::Event(string type){
	_data = NULL;
	_type = type;
}

Event::Event(string type,void* data){
	_data = data;
	_type = type;
}

Event::Event(void* data){
	_data = data;
}

string Event::getType(){
	return _type;
}

void* Event::getData(){
	return _data;
}


Event::~Event() {
}

} /* namespace plter */
