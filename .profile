# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Variables that other applications need

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    if [[ $PATH != *"$HOME/bin"* ]]; then
        PATH="$PATH:$HOME/bin"
    fi
fi

# set PATH so it includes user's .local bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    if [[ $PATH != *"$HOME/.local/bin"* ]]; then
        PATH="$PATH:$HOME/.local/bin"
    fi
fi

# set PATH so it includes swift bin if it exists
if [ -d "$HOME/.local/swift/usr/bin" ]; then
    if [[ $PATH != *"$HOME/.local/swift/usr/bin"* ]]; then
        PATH="$PATH:$HOME/.local/swift/usr/bin"
    fi
fi

# set LD_LIBRARY_PATH so it includes system's local lib if it exists
if [ -d "/usr/local/lib" ]; then
    if [[ $LD_LIBRARY_PATH != *"/usr/local/lib"* ]]; then
        LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
    fi
fi

# set LD_LIBRARY_PATH so it includes user's .local lib if it exists
if [ -d "$HOME/.local/lib" ]; then
    if [[ $LD_LIBRARY_PATH != *"$HOME/.local/lib"* ]]; then
        LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
    fi
fi

# set C_INCLUDE_PATH so it includes user's .local include if it exists
if [ -d "$HOME/.local/include" ]; then
    if [[ $C_INCLUDE_PATH != *"$HOME/.local/include"* ]]; then
        C_INCLUDE_PATH="$HOME/.local/include:$C_INCLUDE_PATH"
    fi
fi

# set CPLUS_INCLUDE_PATH so it includes user's .local include if it exists
if [ -d "$HOME/.local/include" ]; then
    if [[ $CPLUS_INCLUDE_PATH != *"$HOME/.local/include"* ]]; then
        CPLUS_INCLUDE_PATH="$HOME/.local/include:$CPLUS_INCLUDE_PATH"
    fi
fi

# set CPATH so it includes user's .local include if it exists
if [ -d "$HOME/.local/include" ]; then
    if [[ $CPATH != *"$HOME/.local/include"* ]]; then
        CPATH="$HOME/.local/include:$CPATH"
    fi
fi

if [ -d "/usr/local/cuda" ]; then
    PATH="$PATH:/usr/local/cuda/bin"
    CUDA_HOME=/usr/local/cuda
    CUDA_ROOT=/usr/local/cuda/bin
    if [ -z $LD_LIBRARY_PATH ]; then
        LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/include"
    else
        LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/include"
    fi
fi

export PATH
export LD_LIBRARY_PATH
export C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH
export CPATH
export CUDA_HOME
export CUDA_ROOT

export GTK_THEME=Yaru-blue-dark

export QT_PLUGIN_PATH=/usr/local/lib/x86_64-linux-gnu/plugins

if [[ $XDG_SESSION_TYPE == *"wayland"* ]]; then
    export XCURSOR_SIZE=24
fi

export QT_QPA_PLATFORMTHEME=
export QT_QPA_PLATFORM=
if [[ $XDG_SESSION_TYPE == *"wayland"* ]] ; then
    export QT_QPA_PLATFORMTHEME=qt5ct
    # export QT_QPA_PLATFORM="wayland"
    export QT_QPA_PLATFORM="wayland;xcb"
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export ANDROID_NDK=/mnt/Data/Android/android-ndk-r27

# symlink enables cache from different partition
export UV_CACHE_DIR=/opt/uv/cache
export UV_LINK_MODE=symlink

export OLLAMA_HOST=http://0.0.0.0:11434
export OLLAMA_MODELS=/mnt/HDExtra/ollama/.ollama/models

# enforce RADV vulkan implementation
export AMD_VULKAN_ICD=RADV

# increase AMD and Intel cache size to 12GB
export MESA_SHADER_CACHE_MAX_SIZE=12G

export __GL_SHADER_DISK_CACHE_SIZE=12000000000

export EMSDK=/mnt/Data/CPP_Projects/emsdk_linux
# see https://stackoverflow.com/questions/73908737/permission-denied-when-running-go-from-makefile
# source $EMSDK/emsdk_env.sh 2>/dev/null 1>/dev/null

export NVM_DIR="/mnt/HDExtra/bin/nodejs/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PERF_BUILDID_DIR=/mnt/HDExtra/tmp/perf-debug

export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export PKG_CONFIG_ALLOW_SYSTEM_LIBS=1
