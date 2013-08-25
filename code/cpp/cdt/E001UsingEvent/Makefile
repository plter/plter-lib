CXXFLAGS =	-O2 -g -Wall -fmessage-length=0 -I ../plib-common/ 

OBJS =		UsingEvent.o

LIBS =../plib-common/bin/libpcommon.a

TARGET =	./bin/UsingEvent

$(TARGET):	$(OBJS)
	$(CXX) -o $(TARGET) $(OBJS) $(LIBS)

all:	$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
