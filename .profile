# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    if [[ $PATH != *"$HOME/bin"* ]] ; then
        PATH="$HOME/bin:$PATH"
    fi
fi

# set PATH so it includes user's .local bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    if [[ $PATH != *"$HOME/.local/bin"* ]] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi
fi

# set PATH so it includes swift bin if it exists
if [ -d "$HOME/.local/swift/usr/bin" ] ; then
    if [[ $PATH != *"$HOME/.local/swift/usr/bin"* ]] ; then
        PATH="$PATH:$HOME/.local/swift/usr/bin"
    fi
fi

# set LD_LIBRARY_PATH so it includes system's local lib if it exists
if [ -d "/usr/local/lib" ] ; then
    if [[ $LD_LIBRARY_PATH != *"/usr/local/lib"* ]] ; then
        LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
    fi
fi

# set LD_LIBRARY_PATH so it includes user's .local lib if it exists
if [ -d "$HOME/.local/lib" ] ; then
    if [[ $LD_LIBRARY_PATH != *"$HOME/.local/lib"* ]] ; then
        LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
    fi
fi

# set C_INCLUDE_PATH so it includes user's .local include if it exists
if [ -d "$HOME/.local/include" ] ; then
    if [[ $C_INCLUDE_PATH != *"$HOME/.local/include"* ]] ; then
        C_INCLUDE_PATH="$HOME/.local/include:$C_INCLUDE_PATH"
    fi
fi

# set CPLUS_INCLUDE_PATH so it includes user's .local include if it exists
if [ -d "$HOME/.local/include" ] ; then
    if [[ $CPLUS_INCLUDE_PATH != *"$HOME/.local/include"* ]] ; then
        CPLUS_INCLUDE_PATH="$HOME/.local/include:$CPLUS_INCLUDE_PATH"
    fi
fi

# set CPATH so it includes user's .local include if it exists
if [ -d "$HOME/.local/include" ] ; then
    if [[ $CPATH != *"$HOME/.local/include"* ]] ; then
        CPATH="$HOME/.local/include:$CPATH"
    fi
fi

if [ -d "/usr/local/cuda" ] ; then
    PATH="/usr/local/cuda/bin:$PATH"
    CUDA_HOME=/usr/local/cuda
    CUDA_ROOT=/usr/local/cuda/bin
    if [ -z $LD_LIBRARY_PATH ] ; then
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

export GTK_THEME=Yaru-blue-dark

export QT_PLUGIN_PATH=/usr/local/lib/x86_64-linux-gnu/plugins

if [[ $XDG_SESSION_TYPE == *"wayland"* ]] ; then
    export XCURSOR_SIZE=24
fi
