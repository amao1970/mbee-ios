#!/usr/bin/bash
# 工程名
PROJECT_NAME="小蜜蜂"
# scheme Name
SCHEME_NAME="mbee"
# 证书
CODE_SIGN_DISTRIBUTION="iPhone Distribution: xxxx"
# info.plist路径
INFO_PLIST_PATH="./${PROJECT_NAME}/Supporting Files/info.plist"
# 输出ipa目录
OUTPUT_IPA_DIR=~/Desktop/"${PROJECT_NAME}_IPA"
# 上传ipa名称
UPLOAD_IPA_NAME="${PROJECT_NAME}.ipa"

#创建输出ipa文件夹
if [ ! -d "${OUTPUT_IPA_DIR}" ]; then
    mkdir "${OUTPUT_IPA_DIR}"
fi

#取版本号
echo "${INFO_PLIST_PATH}"
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${INFO_PLIST_PATH}")

#取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${INFO_PLIST_PATH}")

DATE="$(date +%Y%m%d)"
IPANAME="${PROJECT_NAME}_V${bundleShortVersion}_${DATE}.ipa"

# # //下面2行是没有Cocopods的用法
# echo "=================clean================="
# xcodebuild -target "${PROJECT_NAME}"  -configuration 'Release' clean

# echo "+++++++++++++++++build+++++++++++++++++"
# xcodebuild -target "${PROJECT_NAME}" -sdk iphoneos -configuration 'Release' CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}" SYMROOT='$(PWD)'

# //下面2行是集成有Cocopods的用法
echo "=================clean================="
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}"  -configuration 'Release' clean

echo "+++++++++++++++++build+++++++++++++++++"
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${SCHEME_NAME}" -sdk iphoneos -configuration 'Release' CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}" SYMROOT='$(PWD)'

xcrun -sdk iphoneos PackageApplication "./Release-iphoneos/${SCHEME_NAME}.app" -o "${OUTPUT_IPA_DIR}/${IPANAME}"
