# Build the fastcgi library.

CXX		= g++
AR		= ar
RANLIB		= ranlib

CPPFLAGS	=
CXXFLAGS	= -O -finline-functions -Wall -pedantic -pipe
LDFLAGS		= -s

OBJS		= protocol_driver.o process_messages.o process_admin_messages.o \
		  process_stream_messages.o request.o fcgi_error.o

.cpp.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $<

all:		libfastcgi.a

libfastcgi.a:	$(OBJS)
	@rm -f $@
	$(AR) cr $@ $(OBJS)
	$(RANLIB) $@

test:		test.o libfastcgi.a
	$(CXX) $(LDFLAGS) -o $@ test.o libfastcgi.a

clean::
	rm -f libfastcgi.a $(OBJS)
	rm -f test test.o

# Dependencies

fcgi_error.o: fastcgi.hpp
process_admin_messages.o: internal.hpp fastcgi.hpp
process_messages.o: internal.hpp fastcgi.hpp
protocol_driver.o: internal.hpp fastcgi.hpp
request.o: internal.hpp fastcgi.hpp
test.o: fastcgi.hpp
