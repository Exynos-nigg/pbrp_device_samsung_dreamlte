# PBRP building script for CircleCI
# coded by bruh™ aka Live0verfl0w

MANIFEST_LINK=git://github.com/PitchBlackRecoveryProject/manifest_pb.git
BRANCH=android-8.1
DEVICE_CODENAME=dreamlte
GITHUB_USER=Live0verfl0w
GITHUB_EMAIL=vsht700@gmail.com
WORK_DIR=$(pwd)/PBRP-${DEVICE_CODENAME}
JOBS=$(nproc)
SPACE=$(df -h)
RAM=$(free mem -h)

# Check CI specs!
echo "Checking specs!"
echo "CPU cores = ${JOBS}"
echo "Space available = ${SPACE}"
echo "RAM available = ${RAM}"
sleep 25 

# Set up git!
echo ""
echo "Setting up git!"
git config --global user.name ${GITHUB_USER}
git config --global user.email ${GITHUB_EMAIL}
git config --global color.ui true

# Install dependencies!
echo ""
echo "Installing dependencies!"
apt-get -y update && apt-get -y upgrade && apt-get -y install bc bison build-essential curl flex g++-multilib gcc gcc-multilib clang gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk python ccache libtinfo5 repo libstdc++6 libssl-dev rsync
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# make directories
echo ""
echo "Setting work directories!"
mkdir ${WORK_DIR} && cd ${WORK_DIR}

# set up rom repo
echo ""
echo "Syncing rom repo!"
repo init -u ${MANIFEST_LINK} -b ${BRANCH}
repo sync -j${JOBS}

# clone device sources
echo ""
echo "Cloning device sources!"

# Device tree
git clone -b android-9.0 https://github.com/Live0verfl0w/pbrp_device_samsung_dreamlte.git device/samsung/dreamlte 

# Kernel source 
git clone -b 9 https://github.com/corsicanu/android_kernel_samsung_universal8895.git kernel/samsung/universal8895 

# extra dependencie for building dtbo
git clone -b lineage-16.0 https://github.com/LineageOS/android_hardware_samsung.git hardware/samsung

# Start building!
echo ""
echo "Starting build!"
export ALLOW_MISSING_DEPENDENCIES=true && . build/envsetup.sh && lunch omni_${DEVICE_CODENAME}-eng && mka recoveryimage -j${JOBS}

# copy final product to another folder
echo ""
echo "Copying final product to another dir!"
mkdir ~/output
cp ${WORK_DIR}/out/target/product/*/*.zip ~/output/
cp ${WORK_DIR}/out/target/product/*/recovery.img ~/output/

echo ""
echo "Done baking!"
echo "Build will be uploaded in the artifacts section in CircleCI! =) "
echo ""
