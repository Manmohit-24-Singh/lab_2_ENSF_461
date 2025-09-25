# Makefile
# The following variable to store compiler command
CC ?= gcc
CFLAGS = -Wall

BINS := gen_numbers.out select_arg.out gen_in_range.out

OBJ_gen_numbers := gen_numbers.o utils.o
OBJ_select_arg  := select_arg.o  utils.o
OBJ_gen_in_range:= gen_in_range.o

UNAME_S := $(shell uname -s)

# Checks if the OS is Linux
# If yes, it builds all files
# If not, it prints the error message
ifeq ($(UNAME_S),Linux)
all: $(BINS)
else
all:
	@echo "Sorry, I prefer Linux"
endif

# Using Wildcards and target placeholders rather than manually writing down prerequisites and targets
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

gen_numbers.out: $(OBJ_gen_numbers)
	$(CC) $^ -o $@

select_arg.out: $(OBJ_select_arg)
	$(CC) $^ -o $@

gen_in_range.out: $(OBJ_gen_in_range)
	$(CC) $^ -o $@

.PHONY: clean

# This target deletes all generated executable files
clean:
	@rm -f *.o $(BINS)

.PHONY: test
test: $(BINS)
	@./gen_numbers.out 3 >/dev/null ; RC=$$?; if [ $$RC -ne 0 ]; then exit 1; fi
	@./select_arg.out foo bar >/dev/null ; RC=$$?; if [ $$RC -ne 0 ]; then exit 1; fi
	@./gen_in_range.out 1 5 >/dev/null ; RC=$$?; if [ $$RC -ne 0 ]; then exit 1; fi
	@echo "Working as expected, all tests passed!"

.DEFAULT_GOAL := all
