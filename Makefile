SDIR := src
IDIR := inc
ODIR := obj

SOURCES := $(wildcard $(SDIR)/*.cpp)
INCLUDE := $(wildcard $(IDIR)/*.hpp)
OBJECTS := $(addprefix $(ODIR)/, $(notdir $(SOURCES:.cpp=.o)))

CXX := g++
LD := g++
CXXFLAGS := -c -g -Wall -Wextra -Wpedantic -Werror -std=c++11 -I$(IDIR)
LDFLAGS := -lsfml-window -lsfml-system -lsfml-graphics -lsfml-audio 

TARGET := game

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) $^ -o $@ $(LDFLAGS)
$(OBJECTS): | $(ODIR)
$(ODIR):
	mkdir -p $(ODIR)
$(ODIR)/%.o: $(SDIR)/%.cpp $(INCLUDE)
	$(CXX) $< -o $@ $(CXXFLAGS)

.PHONY: test clean

test: $(TARGET)
	./$(TARGET)

clean:
	@rm -f $(TARGET)
	@rm -f $(OBJECTS)
