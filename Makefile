# Build the fastcgi library.

CXX		= g++
AR		= ar
RANLIB		= ranlib

CPPFLAGS	=
CXXFLAGS	= -Wall
LDFLAGS		=

OBJS		=

.cpp.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $<

all:		libfastcgi.a test

libfastcgi.a:	$(OBJS)
	@rm -f $@
	$(AR) cr $@ $(OBJS)
	$(RANLIB) $@

test:		test.o libfastcgi.a
	$(CXX) $(LDFLAGS) -o $@ test.o libfastcgi.a

clean::
	rm -f libfastcgi.a $(OBJS)
	rm -f test test.o

install:	test
	install -s -c -o bin -g bin -m 755 test /usr/local/apache/fcgi-bin/test.fcgi

# Dependencies

test.o:		fastcgi.hpp
