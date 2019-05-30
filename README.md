# termux-fedora

A script to install a Fedora chroot into Termux.

# Alternative

You can also try running https://github.com/nmilosev/anyfed which is a bit more versatile in creating chroot's.

# Instructions

Supported images:

- f30_arm64
- f29_arm64
- f28_arm64
- f27_arm64
- f27_arm
- f26_arm64
- f26_arm
- f25_arm64
- f25_arm
- f24_arm64
- f24_arm

```
pkg install wget -y && /data/data/com.termux/files/usr/bin/wget https://raw.githubusercontent.com/nmilosev/termux-fedora/master/termux-fedora.sh

sh termux-fedora.sh [desired image]
```

For example:

```
sh termux-fedora.sh f30_arm64
```

To uninstall:

```
sh termux-fedora.sh uninstall
```

https://nmilosev.svbtle.com/termuxfedora-install-fedora-on-your-phone-with-termux
