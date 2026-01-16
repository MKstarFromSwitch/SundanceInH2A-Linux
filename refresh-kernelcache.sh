#!/bin/bash
clear
echo Remake SundanceInH2A-Linux KernelCache
echo Only use this tool if you want to refresh KernelCache! [delete existing KernelCache and make it again]
echo KernelCache can be deleted and remade with this script.
echo
echo Your current directory is: "$PWD"
echo Unless this is the directory where SundanceInH2A-Linux files exist, hit Ctrl+C and cd into the directory where SundanceInH2A-Linux is git-cloned.
echo
read -p "Press any key to refresh KernelCache (make sure curl is installed)..." -n1 -s
echo
echo Deleting existing KernelCache files...
rm -f "$PWD/artifacts/kernelcache.n18ap.bin"
echo
echo "Deleted normal KernelCache successfully. (Ignore any \"No such file or directory\" errors)"
rm -f "$PWD/artifacts/kernelcache.jailbroken.n18ap.bin"
echo
echo "Deleted jailbroken KernelCache successfully. (Ignore any \"No such file or directory\" errors)"
echo
echo "The script will now download normal KernelCache."
echo
curl "https://gist.githubusercontent.com/NyanSatan/1cf6921821484a2f8f788e567b654999/raw/7fa62c2cb54855d72b2a91c2aa3d57cab7318246/magic-A63970m.b64" | base64 -d | gunzip > kernelcache.n18ap.bin
mv "$PWD/kernelcache.n18ap.bin" "$PWD/artifacts/"
echo
echo Normal KernelCache downloaded successfully.
echo
echo "The script will now download jailbroken KernelCache."
echo
curl https://gist.githubusercontent.com/NyanSatan/1cf6921821484a2f8f788e567b654999/raw/095022a2e8635ec3f3ee3400feb87280fd2c9f17/magic-A63970m-jb.b64 | base64 -d | gunzip > kernelcache.jailbroken.n18ap.bin
mv "$PWD/kernelcache.jailbroken.n18ap.bin" "$PWD/artifacts/"
echo
echo Jailbroken KernelCache downloaded successfully.
echo
read -p "Script complete. You can now exit by pressing any key." -n1 -s
clear
exit


