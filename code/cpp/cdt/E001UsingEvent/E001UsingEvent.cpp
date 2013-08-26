//============================================================================
// Name        : E001UsingEvent.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C, Ansi-style
//============================================================================

#include <stdio.h>
#include <stdlib.h>
#include <EventListener.h>
#include <Event.h>
#include <Object.h>
#include <EventListenerList.h>

using namespace plter;

class Listener:public EventListener {
public:
	virtual bool execute(Event* e,Object* data){
		puts("Listener execute");
		return true;
	};

private:
};

int main(void) {

	EventListenerList* el = new EventListenerList();
	Listener* l = new Listener();
	el->addListener(l);
	el->dispatch(NULL);
	return EXIT_SUCCESS;
}
