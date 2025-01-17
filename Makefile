#Makefile vypůjčený z ukázkové semestrální práce od Radka Huška

LOGIN = jiricma3
CXX = g++
BASIC_FLAGS = -std=c++17 -g -Wall -pedantic
FLAGS = -lstdc++fs

ZIP = Makefile Doxyfile DOCUMENTATION.md zadani.txt prohlaseni.txt \
  .gitignore $(wildcard examples/*) $(wildcard src/*)

SOURCES = $(wildcard src/*.cpp)
OBJECTS = $(patsubst src/%.cpp, build/%.o, ${SOURCES})
DEPS = $(patsubst src/%.cpp, build/%.dep, ${SOURCES})

.PHONY: all compile run valgrind doc clean count zip

all: compile doc

compile: ${LOGIN}

${LOGIN}: ${OBJECTS}
	@mkdir -p build/
	${CXX} ${BASIC_FLAGS} $^ -o $@ ${FLAGS}

build/%.o: src/%.cpp 
	@mkdir -p build/
	${CXX} ${BASIC_FLAGS} -c $< -o $@ ${FLAGS}

run: compile
	./${LOGIN}

valgrind: compile
	valgrind ./${LOGIN}

doc: doc/index.html

doc/index.html: Doxyfile DOCUMENTATION.md $(wildcard src/*)
	doxygen Doxyfile

count:
	wc -l src/*

clean:
	rm -rf build doc
	rm -f ${LOGIN} ${LOGIN}.zip

zip: ${LOGIN}.zip

${LOGIN}.zip: ${ZIP}
	rm -rf tmp/
	rm -f $@
	mkdir -p tmp/${LOGIN}/
	cp --parents -r $^ tmp/${LOGIN}/
	cd tmp/ && zip -r ../$@ ${LOGIN}/
	rm -rf tmp/

build/%.dep: src/%.cpp src/*
	@mkdir -p build/
	${CXX} -MM -MT $(patsubst src/%.cpp, build/%.o, $<) $< > $@

include ${DEPS}

