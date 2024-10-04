#!/bin/sh

# Build ipa file
flutter build ios

# Paused, waiting to continue
echo -n "Press any key to continue..."
read -n 1 -s
echo

RootPath=$(pwd)
Workpath="$RootPath/build/ios/iphoneos"
Payload="$Workpath/Payload"
Runner_app="$Workpath/Runner.app"
Payload_app="$Workpath/Payload/Payload.app"
Payload_ipa="$Workpath/Payload.ipa"

# Clear
if [ -d "$Payload" ]; then
  rm -r $Payload
fi

# Create
if [ ! -d "$Payload" ]; then
  mkdir -p "$Payload"
fi

if [ -d "$Runner_app" ]; then
  cp -r $Runner_app $Payload_app

else
  echo "$Runner_app not found!"
fi

cd $Workpath
zip -r $Payload_ipa Payload
cd $RootPath

echo "------"
echo "Build $Payload_ipa success!"