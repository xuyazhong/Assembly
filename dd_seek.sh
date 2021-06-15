#/bin/bash
dd if=a.bin of=disk.img bs=512 seek=128 count=1 conv=notrunc
