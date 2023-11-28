# 编译boot.asm
build/%.bin: src/%.asm
	nasm $< -o $@

# 写入到虚拟硬盘
build/master.img: build/boot.bin build/loader.bin
	dd if=build/boot.bin of=build/master.img bs=512 count=1 conv=notrunc
	dd if=build/loader.bin of=build/master.img bs=512 count=4 seek=2 conv=notrunc # seek=2表示从第二个扇区开始写入
#删除生成的文件，和img.lock文件,不清楚这个文件为什么会出现，但是一出现这个,bochs就会报错,所以要删掉
.PHONY: clean # 伪目标,不生成文件,只是执行命令,不管有没有clean文件,都执行命令
clean:
	rm -rf build/bx_enh_dbg.ini
	rm -f build/*.bin build/*.img.lock

# 运行bochs
.PHONY: bochs
bochs: build/master.img
	cd build && bochs -q
