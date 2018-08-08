qemu-system-x86_64 -enable-kvm disk.img -m 512 -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device e1000,netdev=net0,mac=00:aa:00:60:00:01
