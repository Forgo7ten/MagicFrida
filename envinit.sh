echo "download dependency"
sudo apt-get install -y build-essential curl git lib32stdc++-9-dev libc6-dev-i386 nodejs npm python3-dev python3-pip gcc-multilib g++-multilib
sudo apt install -y unzip
python3 -m pip install lief
WORKSPACE=$(dirname $(pwd))
if [ ! -d "$WORKSPACE/android-ndk-r22b" ]; then
  echo "ndk-r22b不存在"
  if [ ! -f "../android-ndk-r22b-linux-x86_64.zip" ]; then
    wget -P ../ https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip
    echo "ndk下载成功，下载目录 $WORKSPACE/android-ndk-r22b"
  fi
  unzip ../android-ndk-r22b-linux-x86_64.zip -d ../
  echo "ndk解压成功. You can run 'rm -rf $WORKSPACE/android-ndk-r22b-linux-x86_64.zip' to delete the ndk cache."
fi
if [ ! -d "build" ]; then
  mkdir build
fi
python3 releng/generate-version-header.py "build/frida-version.h"
echo "generate frida-version.h"
cd frida-core
git am ../Patchs/frida-core/*.patch && echo "Patch success!"
cd ..
echo "env init success!"
echo "需手动设置环境变量"
echo "=====>"
echo "export ANDROID_NDK_ROOT=$WORKSPACE/android-ndk-r22b"
echo "export PATH=\$ANDROID_NDK_ROOT:\$PATH"
echo "<====="
