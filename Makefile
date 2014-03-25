INCS = -I. -I/usr/include -I/usr/local/include
LIBS = -L/usr/lib -L/usr/local/lib -pthread -ljsoncpp -lboost_system -lboost_thread

CXXFLAGS = -std=c++11 -Wall -pedantic -pipe -O2 ${INCS} -ggdb
LDFLAGS = -g ${LIBS}

CXX = clang++

SOURCES := $(wildcard src/*.cpp) $(wildcard src/RSC/*.cpp) $(wildcard src/RSC/model/*.cpp)
OBJECTS := $(SOURCES:src/%.cpp=bin/%.o)

all: mkbin options $(OBJECTS) autoemu

mkbin:
	@mkdir -p bin/RSC/model

options:
	@echo autoemu build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "CXXFLAGS = ${CXXFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CXX      = ${CXX}"

bin/%.o: src/%.cpp
	@echo CXX $<
	@${CXX} -static -o $@ -c ${CXXFLAGS} $<

autoemu:
	@echo CXX -o $@
	@${CXX} -o $@ ${OBJECTS} ${LDFLAGS}
	@echo $@ finished compiling.

clean:
	@echo cleaning
	@rm -rf bin/* autoemu
