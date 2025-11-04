# Applications, `.desktop` files

In this folder we put our `.desktop` files, which are used to launch applications.  
If you have a `.desktop` file in `/usr/shar/applications` and another in `$HOME/.local/share/applications`, the _$HOME_ one will override the system one.  

A minimal file is like this  

```ini
[Desktop Entry]
Name=My Awesome App
Categories=Development;
Exec=myprogram
Icon=myicon
Type=Application
```

We need to set permission to execute `chmod +x file.desktop` so it can show-up in the Start Menu, and also double click to open.  

I don't know what are all the options, but these are some that I've seen.  

- Name: the name that will show up. We can have variants depending on the system language, like 
    ```ini
    Name=Applications (bauh)
    Name[pt]=Aplicativos (bauh)
    Name[es]=Aplicaciones (bauh)
    ```
- Actions: don't know
- Categories: your system may decide to group icons in the same category. There can be more than one, separated by `;`. `Utility;TextEditor;Development;`
- Comment: if you hover the desktop icon it will show this comment, also available for different languages `[pt]`, `[es]`. `It does this and that`.
- DBusActivatable: don't know, `true` or `false`.
- Encoding: don't know, example `UTF-8`.
- Exec: the command to execute. In some cases we may need to invoke `env` first. The command must be in your `$PATH` (it can be a symlink). It is not just the executable, we can pass params too `myprogram --option=value1`. Pass `%f` if in a file context.
  - Some applications (ie _Blender_) need permissions from `$HOME`, but _.desktop_ files open from `/`, so, exec with `Exec=sh -c 'cd ~ && blender %f'`
- GenericName: not the name that shows-up, but you can use as search.
- Hidden: don't know, `true` or `false`.
- Icon: the icon that will show-up. Place your icon at `$HOME$/.local/share/icons` or `/usr/share/icons` and you can reference it by name. Or, put the full path to the icon file. Some applications depend on `StartupWMClass` to show the icon in the task bar. Read below.
- InitialPreference: don't know, `[0-9]`
- Keywords: search keywords separated by `;`. Available in other languages. `sound;music editing;voice channel`
- MimeType: a list of mime types separated with `;` to suggest open with this app. `image/jpeg;image/png;image/gif;image/bmp;`
- NoDisplay: don't know, `true` or `false`.
- PrefersNonDefaultGPU: don't know, `true` or `false`.
- StartupNotify: don't know, `true` or `false`.
- StartupWMClass: if running a _X11_ application in a _Wayland_ session the icon might not show-up in the task bar. To find the correct value, launch the application then run `xprop | grep WM_CLASS` then click inside the app window (not the handle bar, inside the app), _xprop_ will print the value to be used here. Relaunch the app to see the icon in the task bar.
- Terminal: opens a terminal window before running `Exec`. Depending on the app the terminal closes right after. `true` or `false`.
- TryExec: a command that is tested before the application show-up in Start Menu.
- Type: I have only seen `Application` so far, don't know what are other options or what they do.
- Version: metadata
- X-AppImage-Version: AppImage metadata
- X-DBUS-ServiceName: don't know, some application ID `org.company.app`
- X-DBUS-StartupType: don't know, `Multi`
- X-DocPath: don't know, `app/index.html`
- X-Flatpak: used to inform the Flatpak Application ID `org.company.app.App`
- X-GNOME-FullName: GNOME metadata
- X-GNOME-Autostart-enabled: start with the system, `true` or `false`.
- X-GNOME-UsesNotifications: don't know, `true` or `false`.
- X-KDE-SubstituteUID: KDE metadata, don't know, `true` or `false`.
- X-KDE-HasTempFileOption: KDE metadata, don't know, `true` or `false`.
- X-MultipleArgs: don't know, `true` or `false`.
