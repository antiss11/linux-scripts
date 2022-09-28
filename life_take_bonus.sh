#!/bin/bash

emulator -avd "Pixel_3a_API_33_x86_64" -no-audio -no-window &
adb wait-for-device ;
cd $HOME/Code/life-by-autobonus;
python main.py;
adb -s $(adb devices | grep -Po "emulator-[[:digit:]]+") emu kill;
exit 0;
