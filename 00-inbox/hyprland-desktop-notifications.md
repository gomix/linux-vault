Notes

# SwayNC

```
%> swaync --version
swaync 0.12.6

%> swaync-client --help
Usage:
  --help <OPTION>
Help:
  -h,    --help                          Show help options
  -v,    --version                       Prints version
Options:
  -R,    --reload-config                 Reload the config file
  -rs,   --reload-css                    Reload the css file. Location change requires restart
  -t,    --toggle-panel                  Toggle the notification panel
  -op,   --open-panel                    Opens the notification panel
  -cp,   --close-panel                   Closes the notification panel
  -d,    --toggle-dnd                    Toggle and print the current dnd state
  -D,    --get-dnd                       Print the current dnd state
  -dn,   --dnd-on                        Turn dnd on and print the new dnd state
  -df,   --dnd-off                       Turn dnd off and print the new dnd state
  -I,    --get-inhibited                 Print if currently inhibited or not
  -In,   --get-num-inhibitors            Print number of inhibitors
  -Ia,   --inhibitor-add [APP_ID]        Add an inhibitor
  -Ir,   --inhibitor-remove [APP_ID]     Remove an inhibitor
  -Ic,   --inhibitors-clear              Clears all inhibitors
  -c,    --count                         Print the current notification count
         --hide-latest                   Hides latest notification. Still shown in Control Center
         --hide-all                      Hides all notifications. Still shown in Control Center
         --close-latest                  Closes latest notification
  -C,    --close-all                     Closes all notifications
  -a,    --action [ACTION_INDEX]         Invokes the action [ACTION_INDEX] of the latest notification
  -sw,   --skip-wait                     Doesn't wait when swaync hasn't been started
  -s,    --subscribe                     Subscribe to notification add and close events
  -swb,  --subscribe-waybar              Subscribe to notification add and close events with waybar support. Read README for example
         --change-cc-monitor             Changes the preferred control center monitor (resets on config reload)
         --change-noti-monitor           Changes the preferred notification monitor (resets on config reload)
```



```
$ dbus-monitor --session "interface='org.freedesktop.Notifications',member='Notify'"

signal time=1786290471.098429 sender=org.freedesktop.DBus -> destination=:1.265 serial=4294967295 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus; member=NameAcquired
   string ":1.265"
signal time=1786290471.098442 sender=org.freedesktop.DBus -> destination=:1.265 serial=4294967295 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus; member=NameLost
   string ":1.265"
method call time=1786290541.863389 sender=:1.69 -> destination=org.freedesktop.Notifications serial=63 path=/org/freedesktop/Notifications; interface=org.freedesktop.Notifications; member=Notify
   string "Google Chrome"
   uint32 0
   string "file:///tmp/com.google.Chrome.scoped_dir.lf1dNe/logo.png"
   string "Guillermo Gómez"
   string "mail.google.com

test email"
   array [
      string "default"
      string "Activate"
      string "settings"
      string "Settings"
   ]
   array [
      dict entry(
         string "desktop-entry"
         variant             string "google-chrome"
      )
      dict entry(
         string "image-path"
         variant             string "/tmp/com.google.Chrome.scoped_dir.lf1dNe/icon.png"
      )
      dict entry(
         string "image_path"
         variant             string "/tmp/com.google.Chrome.scoped_dir.lf1dNe/icon.png"
      )
      dict entry(
         string "urgency"
         variant             byte 1
      )
   ]
   int32 -1
```
