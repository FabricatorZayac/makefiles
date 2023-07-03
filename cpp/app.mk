##
# C++ Application Makefile
#
# @file
# @version 0.1

CXX          := clang++
CXX_STANDARD := 17
RMDIR        := rm -rf
RM           := rm -f
MKDIR        := mkdir

SRC          := ./src
OBJ          := ./obj
BIN          := ./bin
INCLUDE      := ./include

SRCS         := $(shell find $(SRC) -name "*.cpp")
OBJS         := $(patsubst $(SRC)/%.cpp, $(OBJ)/%.o, $(SRCS))
TARGET       := $(BIN)/appname

LDFLAGS      :=
CFLAGS       := -I$(INCLUDE) -std=c++$(CXX_STANDARD) -Wall -Wextra
DEBUGFLAGS   := -O0 -ggdb

.PHONY: all clean run debug lldb gdb

all: $(TARGET)

run: all
	./$(TARGET)

debug: CFLAGS := $(CFLAGS) $(DEBUGFLAGS)
debug: all

lldb: debug
	lldb $(TARGET)

gdb: debug
	gdb $(TARGET)

$(TARGET): $(OBJS) | $(BIN)
	$(CXX) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(OBJ)/%.o: $(SRC)/%.cpp | $(OBJ)
	$(CXX) $(CFLAGS) -c $< -o $@

$(OBJ) $(BIN):
	$(MKDIR) $@

clean:
	$(RMDIR) $(BIN) $(OBJ)

# end
