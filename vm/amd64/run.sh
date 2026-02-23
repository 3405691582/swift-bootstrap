tar xzvf openbsd-amd64.tar.gz
xorriso -volid CIDATA -joliet on -rockridge on -outdev localds.img -map ./cidata/ /
qemu-img create -f qcow2 scratch.qcow2 64G
qemu-img create -f qcow2 tape.qcow2 2G
qemu-system-x86_64 -smp 8 -m 16G \
    -nodefaults -no-user-config -nographic -serial stdio \
    -netdev user,id=net -device virtio-net-pci,netdev=net \
    -drive id=os,file=usr/local/share/openbsd/os.qcow2,format=qcow2,if=none -device virtio-blk-pci,drive=os \
    -drive id=out,file=tape.qcow2,format=qcow2,if=none -device virtio-blk-pci,drive=out \
    -drive id=scratch,file=scratch.qcow2,format=qcow2,if=none -device virtio-blk-pci,drive=scratch \
    -drive id=cidata,file=localds.img,format=raw,if=none -device virtio-blk-pci,drive=cidata
