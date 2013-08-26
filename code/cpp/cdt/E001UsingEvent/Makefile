CXXFLAGS =	-O2 -g -Wall -fmessage-length=0 -I ../plib-common

OBJS =		E001UsingEvent.o

LIBS =../plib-common/bin/libpcommon.a

TARGET =	E001UsingEvent

$(TARGET):	$(OBJS)
	$(CXX) -o $(TARGET) $(OBJS) $(LIBS)

all:	$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
