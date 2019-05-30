#!/data/data/com.termux/files/usr/bin/bash

# input validator and help

case "$1" in
	f24_arm64)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/24/Docker/x86_64/images/Fedora-Docker-Base-24-1.2.x86_64.tar.xz
	    ;;
	f24_arm)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/24/Docker/armhfp/images/Fedora-Docker-Base-24-1.2.armhfp.tar.xz
	    ;;
	f25_arm64)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/25/Docker/x86_64/images/Fedora-Docker-Base-25-1.3.x86_64.tar.xz
	    ;;
	f25_arm)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/25/Docker/armhfp/images/Fedora-Docker-Base-25-1.3.armhfp.tar.xz
	    ;;
	f26_arm64)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/26/Docker/x86_64/images/Fedora-Docker-Base-26-1.5.x86_64.tar.xz
	    ;;
	f26_arm)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/26/Docker/armhfp/images/Fedora-Docker-Base-26-1.5.armhfp.tar.xz
	    ;;
	f27_arm64)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/27/Docker/x86_64/images/Fedora-Docker-Base-27-1.6.x86_64.tar.xz
	    ;;	
	f27_arm)
	    DOCKERIMAGE=https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/27/Docker/armhfp/images/Fedora-Docker-Base-27-1.6.armhfp.tar.xz
	    ;;
	f28_arm64)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/28/Container/aarch64/images/Fedora-Container-Base-28-1.1.aarch64.tar.xz
	    ;;
	f29_arm64)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/29/Container/aarch64/images/Fedora-Container-Base-29-1.2.aarch64.tar.xz
	    ;;
	f30_arm64)
		DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/30/Container/aarch64/images/Fedora-Container-Base-30-1.2.aarch64.tar.xz
		;;
	uninstall)
	    chmod -R 777 ~/fedora
	    rm -rf ~/fedora
	    exit 0
	    ;;
	*)
	    echo $"Usage: $0 {f24_arm64|f24_arm|f25_arm64|f25_arm|f26_arm|f26_arm64|f27_arm|f27_arm64|f28_arm64|f29_arm64|f30_arm64|uninstall}"
	    exit 2
	    ;;
esac


# install necessary packages

pkg install proot tar -y

# get the docker image

mkdir ~/fedora
cd ~/fedora
/data/data/com.termux/files/usr/bin/wget $DOCKERIMAGE -O fedora.tar.xz

# extract the Docker image

/data/data/com.termux/files/usr/bin/tar xvf fedora.tar.xz --strip-components=1 --exclude json --exclude VERSION

# extract the rootfs

/data/data/com.termux/files/usr/bin/tar xpf layer.tar

# cleanup

chmod +w .
rm layer.tar
rm fedora.tar.xz

# fix DNS

echo "nameserver 8.8.8.8" > ~/fedora/etc/resolv.conf

# make a shortcut

cat > /data/data/com.termux/files/usr/bin/startfedora <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
unset LD_PRELOAD && proot --link2symlink -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@fedora \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/startfedora

# all done

echo "All done! Start Fedora with 'startfedora'. Gets update with regular 'dnf update'. "
