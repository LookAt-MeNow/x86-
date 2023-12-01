CFLAGS:= -m32 \
		-fno-asynchronous-unwind-tables \
		-fno-pic \
		-mpreferred-stack-boundary=2 \
		-masm=intel \
		-O0

build/%.s: hello/%.c
	gcc $(CFLAGS) -S $< -o $@

build/%.s: variable/%.c
	gcc $(CFLAGS) -S $< -o $@