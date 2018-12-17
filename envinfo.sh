#!/usr/bin/env bash
# Copyright (c) 2018 Trevor Brindle
# MIT License
# https://github.com/tabrindle/envinfo.sh

# Utilities

findVersion() {
  echo "$1" \
    | sed -ne 's/[^0-9]*\(\([0-9]\.\)\{0,4\}[0-9][^.]\).*/\1/p' \
    | tr -d '[:space:]'
}

replaceUserInPath() {
  echo ~${1#${HOME//\//\\/}}
}

# Helpers

## System

getOSInfo () {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_VERSION="macOS "$(sw_vers | grep ProductVersion: | awk '{print $2}')""
  fi
}

getCPUInfo () {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    NUM_CPU=$(sysctl -n hw.physicalcpu)
    CPU_MODEL=$(sysctl -a | grep 'machdep.cpu.brand_string:' | cut -d ":" -f2 | cut -c 2-)
    CPU_INFO=$(echo \("$NUM_CPU"\) "$CPU_MODEL")
  fi
}

getMemoryInfo () {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    AVAILABLE_MEMORY="$(($(vm_stat | grep 'Pages free:' | awk '{print $3}' | cut -d "." -f1) * 4096))"
  fi
  TOTAL_MEMORY=$(sysctl -n hw.memsize)
}

getShellInfo () {
  SHELL_VERSION=$(findVersion "$("$SHELL" --version)")
}

## Binaries

getNodeInfo () {
  NODE_PATH=$(command -v node)
  NODE_RAW_VERSION=$($NODE_PATH -V 2>&1)
  NODE_VERSION=$(findVersion "$NODE_RAW_VERSION")
  NODE_PATH=$(replaceUserInPath "$NODE_PATH")
}

getnpmInfo () {
  NPM_PATH=$(command -v npm)
  NPM_VERSION=$($NPM_PATH -v)
  NPM_PATH=$(replaceUserInPath "$(command -v npm)")
}

getWatchmanInfo () {
  WATCHMAN_PATH=$(command -v watchman)
  WATCHMAN_VERSION=$($WATCHMAN_PATH -v)
}

getYarnInfo () {
  YARN_PATH=$(command -v yarn)
  YARN_VERSION=$("$YARN_PATH" -v)
  YARN_PATH=$(replaceUserInPath "$YARN_PATH")
}

## Utilities

getCMakeInfo () {
  CMAKE_PATH=$(command -v cmake)
  [ "$CMAKE_PATH" ] && CMAKE_VERSION=$(findVersion "$("$CMAKE_PATH" -v)")
}

getMakeInfo () {
  MAKE_PATH=$(command -v make)
  [ "$MAKE_PATH" ] && MAKE_VERSION=$(findVersion "$("$MAKE_PATH" -v)")
}

getGCCInfo () {
  GCC_PATH=$(command -v gcc)
  [ "$GCC_PATH" ] && GCC_VERSION=$(findVersion "$("$GCC_PATH" -v 2>&1)")
}

getGitInfo () {
  GIT_PATH=$(command -v git)
  [ "$GIT_PATH" ] && GIT_VERSION=$(findVersion "$("$GIT_PATH" --version)")
}

## Servers

getApacheInfo () {
  APACHE_PATH=$(command -v apachectl)
  [ "$APACHE_PATH" ] && APACHE_VERSION=$(findVersion "$("$APACHE_PATH" -v)")
}

## Virtualization

getDockerInfo () {
  DOCKER_PATH=$(command -v docker)
  [ "$DOCKER_PATH" ] && DOCKER_VERSION=$(findVersion "$("$DOCKER_PATH" --version)")
}

getVirtualBoxInfo () {
  VIRTUALBOX_PATH=$(command -v vboxmanage)
  [ "$VIRTUALBOX_PATH" ] && VIRTUALBOX_VERSION=$(findVersion "$("$VIRTUALBOX_PATH" --version)")
}

## IDEs

getChromeInfo () {
  CHROME_PATH=$(mdfind "kMDItemCFBundleIdentifier=='com.google.Chrome'")
  [ "$CHROME_PATH" ] && CHROME_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$CHROME_PATH"/Contents/Info.plist)
}

getAndroidStudioInfo () {
  ANDROID_STUDIO_VERSION=$(/usr/libexec/PlistBuddy -c Print:CFBundleShortVersionString -c Print:CFBundleVersion /Applications/Android\ Studio.app/Contents/Info.plist | tr '\n' ' ')
}

getEmacsInfo () {
  EMACS_PATH=$(command -v emacs)
  [ "$EMACS_PATH" ] && EMACS_VERSION=$(findVersion "$("$EMACS_PATH" --version)")
}

getNanoInfo () {
  NANO_PATH=$(command -v nano)
  [ "$NANO_PATH" ] && NANO_VERSION=$(findVersion "$("$NANO_PATH" --version)")
}

getVSCodeInfo () {
  VSCODE_PATH=$(command -v code)
  [ "$VSCODE_PATH" ] && VSCODE_VERSION=$(findVersion "$("$VSCODE_PATH" --version)")
}

getVimInfo () {
  VIM_PATH=$(command -v vim)
  [ "$VIM_PATH" ] && VIM_VERSION=$(findVersion "$("$VIM_PATH" --version)")
}

getXcodeInfo () {
  XCODE_PATH=$(command -v xcodebuild)
  [ "$XCODE_PATH" ] && XCODE_VERSION=$(findVersion "$("$XCODE_PATH" -version)")
}

## Languages

getBashInfo () {
  BASH_PATH=$(command -v bash)
  [ "$BASH_PATH" ] && BASH_VERSION=$(findVersion "$("$BASH_PATH" --version)")
}

getJavaInfo () {
  JAVA_PATH=$(command -v javac)
  [ "$JAVA_PATH" ] && JAVA_VERSION=$(findVersion "$("$JAVA_PATH" -version 2>&1)")
}

getGoInfo () {
  GO_PATH=$(command -v go)
  [ "$GO_PATH" ] && GO_VERSION=$(findVersion "$("$GO_PATH" version)")
}

getPHPInfo () {
  PHP_PATH=$(command -v php)
  [ "$PHP_PATH" ] && PHP_VERSION=$(findVersion "$("$PHP_PATH" --version)")
}

getPerlInfo () {
  PERL_PATH=$(command -v perl)
  [ "$PERL_PATH" ] && PERL_VERSION=$(findVersion "$("$PERL_PATH" --version)")
}

getPythonInfo () {
  PYTHON_PATH=$(command -v python)
  [ "$PYTHON_PATH" ] && PYTHON_VERSION=$(findVersion "$("$PYTHON_PATH" -V 2>&1)")
}

getRubyInfo () {
  RUBY_PATH=$(command -v ruby)
  [ "$RUBY_PATH" ] && RUBY_VERSION=$(findVersion "$("$RUBY_PATH" --version)")
}

## Databases

getMySQLInfo () {
  MYSQL_PATH=$(command -v mysql)
  MYSQL_VERSION=$(findVersion "$("$MYSQL_PATH" --version)")
}

getSQLiteInfo () {
  SQLITE_PATH=$(command -v sqlite3)
  SQLITE_VERSION=$(findVersion "$(sqlite3 --version)")
}

## Browsers

getChromeInfo () {
  CHROME_PATH=$(mdfind "kMDItemCFBundleIdentifier=='com.google.Chrome'")
  [ "$CHROME_PATH" ] && CHROME_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$CHROME_PATH"/Contents/Info.plist)
}

getChromeCanaryInfo () {
  CHROME_CANARY_PATH=$(mdfind "kMDItemCFBundleIdentifier=='com.google.Chrome.canary'")
  [ "$CHROME_CANARY_PATH" ] && CHROME_CANARY_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$CHROME_CANARY_PATH"/Contents/Info.plist)
}

getFirefoxInfo () {
  FIREFOX_PATH=$(mdfind "kMDItemCFBundleIdentifier=='org.mozilla.firefox'")
  [ "$FIREFOX_PATH" ] && FIREFOX_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$FIREFOX_PATH"/Contents/Info.plist)
}

getFirefoxDeveloperEditionInfo () {
  FIREFOX_DEVELOPER_PATH=$(mdfind "kMDItemCFBundleIdentifier=='org.mozilla.firefoxdeveloperedition'")
  [ "$FIREFOX_DEVELOPER_PATH" ] && FIREFOX_DEVELOPER_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$FIREFOX_DEVELOPER_PATH"/Contents/Info.plist)
  # echo "$FIREFOX_DEVELOPER_PATH - $FIREFOX_DEVELOPER_VERSION"
}


getFirefoxNightlyInfo () {
  FIREFOX_NIGHTLY_PATH=$(mdfind "kMDItemCFBundleIdentifier=='org.mozilla.nightly'")
  [ "$FIREFOX_NIGHTLY_PATH" ] && FIREFOX_NIGHTLY_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$FIREFOX_NIGHTLY_PATH"/Contents/Info.plist)
}

getSafariInfo () {
  SAFARI_PATH=$(mdfind "kMDItemCFBundleIdentifier=='com.apple.Safari'")
  [ "$SAFARI_PATH" ] && SAFARI_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$SAFARI_PATH"/Contents/Info.plist)
  # echo "$SAFARI_PATH - $SAFARI_VERSION"
}

getSafariTechnologyPreviewInfo () {
  SAFARI_TECHNOLOGY_PREVIEW_PATH=$(mdfind "kMDItemCFBundleIdentifier=='com.apple.SafariTechnologyPreview'")
  [ "$SAFARI_TECHNOLOGY_PREVIEW_PATH" ] && SAFARI_TECHNOLOGY_PREVIEW_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$SAFARI_TECHNOLOGY_PREVIEW_PATH"/Contents/Info.plist)
}

getResults () {
  echo ""

  echo "  System:"
  [ "$OS_VERSION" ] && echo "    OS: $OS_VERSION"
  [ "$CPU_INFO" ] && echo "    CPU: $CPU_INFO"
  [ "$TOTAL_MEMORY" ] && [ "$AVAILABLE_MEMORY" ] && echo "    Memory: $AVAILABLE_MEMORY / $TOTAL_MEMORY"
  [ "$SHELL_VERSION" ] && echo "    Shell: $SHELL_VERSION - $SHELL"

  echo "  Binaries:"
  [ "$NODE_PATH" ] && echo "    Node: $NODE_VERSION - $NODE_PATH"
  [ "$NPM_PATH" ] && echo "    npm: $NPM_VERSION - $NPM_PATH"
  [ "$WATCHMAN_PATH" ] && echo "    Watchman: $WATCHMAN_VERSION - $WATCHMAN_PATH"
  [ "$YARN_PATH" ] && echo "    Yarn: $YARN_VERSION - $YARN_PATH"

  echo "  Utilities:"
  [ "$CMAKE_PATH" ] && echo "    CMake: $CMAKE_VERSION - $CMAKE_PATH"
  [ "$MAKE_PATH" ] && echo "    Make: $MAKE_VERSION - $MAKE_PATH"
  [ "$GCC_PATH" ] && echo "    GCC: $GCC_VERSION - $GCC_PATH"
  [ "$GIT_PATH" ] && echo "    Git: $GIT_VERSION - $GIT_PATH"

  echo "  Servers:"
  [ "$APACHE_PATH" ] && echo "    Apache: $APACHE_VERSION - $APACHE_PATH"

  echo "  Virtualization:"
  [ "$DOCKER_PATH" ] && echo "    Docker: $DOCKER_VERSION - $DOCKER_PATH"
  [ "$VIRTUALBOX_PATH" ] && echo "    VirtualBox: $VIRTUALBOX_VERSION - $VIRTUALBOX_PATH"

  echo "  IDEs:"
  [ "$ANDROID_STUDIO_VERSION" ] && echo "    Android Studio: $ANDROID_STUDIO_VERSION "
  [ "$EMACS_PATH" ] && echo "    Emacs: $EMACS_VERSION - $EMACS_PATH"
  [ "$NANO_PATH" ] && echo "    Nano: $NANO_VERSION - $NANO_PATH"
  [ "$VSCODE_PATH" ] && echo "    VSCode: $VSCODE_VERSION - $VSCODE_PATH"
  [ "$VIM_PATH" ] && echo "    Vim: $VIM_VERSION - $VIM_PATH"
  [ "$XCODE_PATH" ] && echo "    Xcode: $XCODE_VERSION - $XCODE_PATH"

  echo "  Languages:"
  [ "$BASH_PATH" ] && echo "    Bash: $BASH_VERSION - $BASH_PATH"
  [ "$GO_PATH" ] && echo "    Go: $GO_VERSION - $GO_PATH"
  [ "$JAVA_PATH" ] && echo "    Java: $JAVA_VERSION - $JAVA_PATH"
  [ "$PERL_PATH" ] && echo "    Perl: $PERL_VERSION - $PERL_PATH"
  [ "$PHP_PATH" ] && echo "    PHP: $PHP_VERSION - $PHP_PATH"
  [ "$PYTHON_PATH" ] && echo "    Python: $PYTHON_VERSION - $PYTHON_PATH"
  [ "$RUBY_PATH" ] && echo "    Ruby: $RUBY_VERSION - $RUBY_PATH"

  echo "  Databases:"
  [ "$MYSQL_PATH" ] && echo "    MySQL: $MYSQL_VERSION - $MYSQL_PATH"
  [ "$SQLITE_PATH" ] && echo "    SQLite:: $SQLITE_VERSION - $SQLITE_PATH"

  echo "  Browsers:"
  [ "$CHROME_VERSION" ] && echo "    Chrome: $CHROME_VERSION"
  [ "$CHROME_CANARY_VERSION" ] && echo "    Chrome Canary: $CHROME_CANARY_VERSION"
  [ "$FIREFOX_VERSION" ] && echo "    Firefox: $FIREFOX_VERSION"
  [ "$FIREFOX_DEVELOPER_VERSION" ] && echo "    Firefox Developer Edition: $FIREFOX_DEVELOPER_VERSION"
  [ "$FIREFOX_NIGHTLY_VERSION" ] && echo "    Firefox Nightly: $FIREFOX_NIGHTLY_VERSION"
  [ "$SAFARI_VERSION" ] &&  echo "    Safari: $SAFARI_VERSION"
  [ "$SAFARI_TECHNOLOGY_PREVIEW_VERSION" ] && echo "    Safari: $SAFARI_TECHNOLOGY_PREVIEW_VERSION"

  echo ""
}

getOSInfo
getCPUInfo
getMemoryInfo
getShellInfo
getNodeInfo
getnpmInfo
getYarnInfo
getWatchmanInfo
getCMakeInfo
getMakeInfo
getGCCInfo
getGitInfo
getApacheInfo
getDockerInfo
getVirtualBoxInfo
getAndroidStudioInfo
getEmacsInfo
getNanoInfo
getVSCodeInfo
getVimInfo
getXcodeInfo
getBashInfo
getJavaInfo
getGoInfo
getPerlInfo
getPHPInfo
getPythonInfo
getRubyInfo
getMySQLInfo
getSQLiteInfo
getChromeInfo
getChromeCanaryInfo
getFirefoxInfo
getFirefoxDeveloperEditionInfo
getFirefoxNightlyInfo
getSafariInfo
getSafariTechnologyPreviewInfo

getResults
