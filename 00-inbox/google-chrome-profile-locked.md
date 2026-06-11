Root cause, i changed the hostname from `fedora` to `ser9-fedora`, below the error message i get:

```
$ google-chrome
[5182:5182:0610/201007.424297:ERROR:chrome/browser/process_singleton_posix.cc:365] The profile appears to be in use by another Google Chrome process (4569) on another computer (fedora).  Chrome has locked the profile so that it doesn't get corrupted.  If you are sure no other processes are using this profile, you can unlock the profile and relaunch Chrome.
[5182:5182:0610/201007.424361:ERROR:chrome/browser/ui/views/message_box_dialog.cc:199] Unable to show message box: Google Chrome - The profile appears to be in use by another Google Chrome process (4569) on another computer (fedora).  Chrome has locked the profile so that it doesn't get corrupted.  If you are sure no other processes are using this profile, you can unlock the profile and relaunch Chrome.
```

whaResolution, remove locks:

```
gizmo@ser9-fedora:~$ rm -f ~/.config/google-chrome/SingletonLock 
gizmo@ser9-fedora:~$ rm -f ~/.config/google-chrome/SingletonCookie 
gizmo@ser9-fedora:~$ rm -f ~/.config/google-chrome/SingletonSocket 
```