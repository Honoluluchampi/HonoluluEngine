TARGET 		= HonoluluEngine.dylib
TARGETDIR	= ./lib
SRCROOT 	= ./src
SOURCES 	= $(wildcard $(SRCROOT)/*.cpp)
SDL2DIR 	= /usr/local/Cellar/sdl2/2.0.14_1
SDL2IMAGEDIR = /usr/local/Cellar/sdl2_image/2.0.5
COMPILER  	= g++
CFLAGS    	= -Wall -std=c++20 -MMD -MP -g3
LDFLAGS 	= -dynamiclib
LIBS      	= -L$(SDL2IMAGEDIR)/lib -lSDL2_image-2.0.0 -L$(SDL2DIR)/lib -lSDL2-2.0.0
INCLUDE   	= -I$(SDL2IMAGEDIR)/include -I$(SDL2DIR)/include -I./include
OBJROOT 	= ./obj
OBJECTS 	= $(addprefix $(OBJROOT)/, $(notdir $(SOURCES:.cpp=.o)))
DEPENDS   	= $(OBJECTS:.o=.d)

$(TARGETDIR)/$(TARGET): $(OBJECTS)
	-mkdir -p $(TARGETDIR)
	$(COMPILER) $(LDFLAGS) -o $@ $^ $(LIBS)

$(OBJROOT)/%.o: $(SRCROOT)/%.cpp
	-mkdir -p $(OBJROOT)
	$(COMPILER) $(CFLAGS) $(INCLUDE) -o $@ -c $<

all: clean $(TARGET)

clean:
	-rm -r $(OBJROOT) $(TARGETDIR)

-include $(DEPENDS)