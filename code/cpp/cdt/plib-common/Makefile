CXXFLAGS =	-O2 -g -Wall -fmessage-length=0

OBJS =		Event.o \
			EventListener.o \
			EventListenerList.o \
			Object.o 

LIBS =

TARGET =	./bin/libpcommon.a

$(TARGET):	$(OBJS)
	ar -crv $(TARGET) $(OBJS) $(LIBS)

all:	$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
