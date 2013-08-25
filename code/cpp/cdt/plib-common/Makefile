TARGET_NAME=main
OUT_DIR_NAME=bin
OBJ_DIR_NAME=obj
SRC_DIR_NAME=src

all:build
run:
	./$(OUT_DIR_NAME)/$(TARGET_NAME)


rm_dirs:
	rm -r -f $(OBJ_DIR_NAME) 
	rm -r -f $(OUT_DIR_NAME)

make_dirs:
	mkdir $(OBJ_DIR_NAME)
	mkdir $(OUT_DIR_NAME)

main:
	cd $(OBJ_DIR_NAME)&&g++ -c \
	../$(SRC_DIR_NAME)/Event.cpp \
	../$(SRC_DIR_NAME)/EventListener.cpp \
	../$(SRC_DIR_NAME)/EventListenerList.cpp
	
	ar crv ./$(OUT_DIR_NAME)/libpcommon.a \
	./$(OBJ_DIR_NAME)/Event.o \
	./$(OBJ_DIR_NAME)/EventListener.o \
	./$(OBJ_DIR_NAME)/EventListenerList.o
	
build:main  

rebuild:clean make_dirs build


clean:rm_dirs 
