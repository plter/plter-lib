all:main

clean:
	rm -f $(OBJS) $(TARGET)

main:
	g++ \
	-I ../plib-common/src \
	-L ../plib-common/bin \
	-l pcommon \
	-o UsingEvent \
	E001UsingEvent.cpp
	