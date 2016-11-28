#!/bin/sh

# This script configures the TK1 to put Grinch Kernel and ROS workig together, aside the  
# PrimaSense RGBD sensor.


# This part is taken from the http://jetsonhacks.com/2015/05/26/install-grinch-kernel-for-l4t-21-3-on-nvidia-jetson-tk1/
# Here i'm asumming the kernel files has been downloading previously.

sudo apt-get install git -y


# Add Universe and Multiverse packages repository
sudo apt-add-repository restricted
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-get update

# Here the serial DB9 port is Enabled
sudo usermod -a -G dialout ubuntu

# Another useful customization 
sudo apt-get install aptitude -y 
sudo apt-get install bash-completion command-not-found -y
sudo apt-get install terminator

# There are many other configurations about the functionalities cd ..
sudo apt-get install dconf-tools -y
echo 'Please Navigate to org.gnome.settings-daemon.plugins.power and set default button-power action to shutdown'
dconf-editor

# CPU performances 

#para hacer cp por hacerlo desde la carpeta del repositorio 

sudo cp maxPerformance.sh /usr/local/bin/maxPerformance.sh
sudo echo '# Turn up the CPU and GPU for max performance' >> /etc/rc.localcd ~ #copiar esto en el archivo

sudo echo '/usr/local/bin/maxPerformance.sh' >> /etc/rc.local #copiar esto en el archivo
sudo echo ' ' >> /etc/rc.local #copiar esto en el archivo
sudo cp disableUSBAutosuspend.sh /usr/local/bin/disableUSBAutosuspend.sh
sudo echo '# disable USB autosuspend' >> /etc/rc.local
sudo echo '/usr/local/bin/disableUSBAutosuspend.sh' >> /etc/rc.local
echo 'Please remove the first line where is "exit o"'
sudo gedit /etc/rc.local


# Disable Lock by timeout
echo 'Click on “System Settings” in the Unity sidebar'
echo 'Select “Brightness & Lock”'
echo 'Put “Lock” to OFF'
echo 'Uncheck “Require my password when waking from suspend”'
pause

# Now, is time to install ROS!!
sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
sudo dpkg-reconfigure locales
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116
sudo apt-get update
sudo apt-get install ros-indigo-ros-base -y
sudo apt-get install python-rosdep -y
sudo rosdep init
rosdep update
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt-get install python-rosinstall -y
sudo apt-get install ros-indigo-rviz -y
echo "unset GTK_IM_MODULE" >> ~/.bashrc 

sudo apt-get install ros-indigo-rgbd-launch ros-indigo-openni2-camera ros-indigo-openni2-launch -y
sudo apt-get install ros-indigo-rqt ros-indigo-rqt-common-plugins ros-indigo-rqt-robot-plugins -y

