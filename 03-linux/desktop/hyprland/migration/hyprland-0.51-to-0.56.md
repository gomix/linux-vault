# Hyprland 0.51 -> 0.56

The upgrade happened in Fedora 43.

* Previous Origin Repo -> copr:copr.fedorainfracloud.org:solopasha:hyprland
* Current Origin Repo  ->  copr:copr.fedorainfracloud.org:lionheartp:Hyprland
### New COPR repo
```
dnf history info last | grep -i hyprland-0
  Upgrade  hyprland-0:0.56.1-1.fc43.x86_64                    User            copr:copr.fedorainfracloud.org:lionheartp:Hyprland
  Replaced hyprland-0:0.51.1-3.fc43.x86_64                    User            @System
```

### Previous COPR repo

```
dnf history info  54 | grep -y hyprland-0
  Upgrade  hyprland-0:0.51.1-3.fc43.x86_64                    User            copr:copr.fedorainfracloud.org:solopasha:hyprland
  Replaced hyprland-0:0.51.1-3.fc42.x86_64                    User            @System
```

### Config Errors

```
$ hyprctl configerrors

Config error in file /home/ggomezsa/.config/hypr/hyprland.conf.d/layout.conf at line 3: config option <dwindle:pseudotile> does not exist.
Config error in file /home/ggomezsa/.config/hypr/hyprland.conf at line 11: Config error in file /home/ggomezsa/.config/hypr/hyprland.conf.d/layout.conf at line 3: config option <dwindle:pseudotile> does not exist.
Config error in file /home/ggomezsa/.config/hypr/hyprland.conf.d/rules.conf at line 11: windowrulev2 is deprecated. Correct syntax can be found on the wiki.
Config error in file /home/ggomezsa/.config/hypr/hyprland.conf.d/rules.conf at line 14: windowrulev2 is deprecated. Correct syntax can be found on the wiki.
Config error in file /home/ggomezsa/.config/hypr/hyprland.conf.d/rules.conf at line 17: windowrulev2 is deprecated. Correct syntax can be found on the wiki.
Config error in file /home/ggomezsa/.config/hypr/hyprland.conf.d/rules.conf at line 20: windowrulev2 is deprecated. Correct syntax can be found on the wiki.
```

## Fixes

`layout.conf`
```
dwindle {
    # pseudotile = true # removed 0.55+
    preserve_split = true
} 
```

`rules.conf`
```
# # Ignore maximize requests from apps. You'll probably like this.                                                                                                  
# windowrulev2 = suppressevent maximize, class:.*                                                                                                                   
windowrule = match:class .*, suppress_event maximize 

# # Fix some dragging issues with XWayland                                                                                                                          
# windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0                                                                              
windowrule = match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false, no_focus on

# # YouTube Music Desktop App to ws5                                                                                                                                
# windowrulev2 = workspace 5 silent, class:^(YouTube Music Desktop App)$                                                                                            
windowrule = match:class ^(YouTube Music Desktop App)$, workspace 5 silent

# # EasyEffects App to ws5                                                                                                                                          
# windowrulev2 = workspace 5 silent, class:^(com.github.wwmm.easyeffects)$                                                                                          
windowrule = match:class ^(com.github.wwmm.easyeffects)$, workspace 5 silent
```

> I am just documenting what broke my current configuration, go visit Hyprland official documenation for more info.
