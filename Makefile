-include config.mk

TARGET    = ddraw.dll
LDFLAGS   = -Wl,--enable-stdcall-fixup -s -static -shared
CFLAGS    = -Iinc -O2 -march=i486 -Wall
LIBS      = -lgdi32 -lwinmm -ldbghelp -lole32

CC        = i686-w64-mingw32-gcc
WINDRES  ?= i686-w64-mingw32-windres

ifdef DEBUG
	CFLAGS   += -D _DEBUG -D _DEBUG_X
endif

SRCS     := $(wildcard src/*.c) $(wildcard src/*/*.c) res.rc
OBJS     := $(addsuffix .o, $(basename $(SRCS)))

.PHONY: clean all
all: $(TARGET)

%.o: %.rc
	$(WINDRES) -J rc $< $@

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ exports.def $(LIBS)

clean:
	$(RM) $(TARGET) $(OBJS)
