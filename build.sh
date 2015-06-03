 #
 # Copyright � 2014, Varun Chitre "varun.chitre15" <varun.chitre15@gmail.com>
 #
 # Custom build script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 #
#!/bin/bash
# export CROSS_COMPILE="/root/toolchains/arm-eabi-linaro-4.6.2/bin/arm-eabi-"
# export CROSS_COMPILE="/root/cm11/prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin/arm-eabi-"
# export CROSS_COMPILE="/root/linaro/4.9.3-2014.12.20141230.CR83/bin/arm-eabi-"
STRIP="/home/corphish/android/toolchain/linaro-4.9.3-arm-cortex-a15/bin/arm-eabi-strip"
MODULES_DIR="/home/corphish/android/kernel/condor/zapdos_condor/modules"
ZIMAGE="/home/corphish/android/kernel/condor/zapdos_condor/arch/arm/boot/zImage-dtb"
KERNEL_DIR="/home/corphish/android/kernel/taoshan/android_kernel_sony_msm8930-cm-12.0"
MKBOOTIMG="/home/corphish/android/binaries/mkbootimg"
MKBOOTFS="/home/corphish/android/binaries/mkbootfs"
#ZIP_DIR="/home/corphish/android/kernel/android_kernel_sony_msm8930-cm-12.0/zip"
BUILD_START=$(date +"%s")
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=/home/corphish/android/toolchain/linaro-4.9.3-arm-cortex-a15/bin/arm-eabi-
export KBUILD_BUILD_USER="corphish"
export KBUILD_BUILD_HOST="Damned-PC"
if [ -a $KERNEL_DIR/arch/arm/boot/zImage ];
then
rm $ZIMAGE
#rm $MODULES_DIR/*
#rm $ZIP_DIR/boot.img
#rm $ZIP_DIR/system/lib/modules/*
fi
make cm_condor_defconfig
make -j32
if [ -a $ZIMAGE ];
then
echo "Copying modules"
#rm $MODULES_DIR/*
find . -name '*.ko' -exec cp {} $ZIP_DIR/system/lib/modules \;
cd modules
echo "Stripping modules for size"
$STRIP --strip-unneeded *.ko
#zip -9 modules *
#cd $KERNEL_DIR
#echo "Creating boot image"
#$MKBOOTFS ramdisk/ > $KERNEL_DIR/ramdisk.cpio
#cat $KERNEL_DIR/ramdisk.cpio | gzip > $KERNEL_DIR/root.fs
#$MKBOOTIMG --kernel $ZIMAGE --ramdisk $KERNEL_DIR/root.fs --cmdline "console=ttyHSL0,115200,n8 androidboot.hardware=qcom androidboot.selinux=permissive user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 maxcpus=2" --base 0x80200000 --pagesize 2048 --ramdiskaddr 0x02000000 -o $KERNEL_DIR/boot.img
#cp boot.img $ZIP_DIR/
#echo "Building flashable zip"
#cd $ZIP_DIR
#zip -r test *
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
else
echo "Compilation failed! Fix the errors!"
fi

