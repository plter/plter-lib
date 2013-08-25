//============================================================================
// Name        : E001UsingEvent.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C, Ansi-style
//============================================================================

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <Event.h>
#include <EventListenerList.h>
#include <EventListener.h>

using namespace plter;
using namespace std;


class Listener:public EventListener{
public:
	virtual bool execute(Event* e,void* target){
		cout<<"Handle Event[Event type:"<<e->getType()<<"]"<<endl;
		return true;
	};
};


int main(void) {

	EventListenerList* el = new EventListenerList();

	Listener* l = new Listener();
	Event* e = new Event("Hello");
	el->addListener(l);
	el->dispatch(e);
	el->removeListener(l);
	el->dispatch(e);

	delete l;
	delete el;
	delete e;

	return EXIT_SUCCESS;
}
