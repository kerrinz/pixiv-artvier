#!/bin/sh

RootPath=$(pwd)
Workpath="$RootPath/build/ios/iphoneos"
Payload="$Workpath/Payload"
Runner_app="$Workpath/Runner.app"
Payload_app="$Workpath/Payload/Payload.app"
Payload_ipa="$Workpath/Payload.ipa"

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