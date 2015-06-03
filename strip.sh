STRIP="/home/aniruddhc/vortex/toolchains/linaro-4.9.3-arm-cortex-a15/bin/arm-eabi-strip"
cd modules
echo "Stripping modules for size"
$STRIP --strip-unneeded *.ko
