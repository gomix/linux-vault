Propósito, configurar mi Fedora para reproducir mi música en más de un dispositivo conectado.

```
$ wpclt status
PipeWire 'pipewire-0' [1.6.8, gizmo@ser9-fedora, cookie:335043360]
 └─ Clients:
        33. uresourced                          [1.6.8, gizmo@ser9-fedora, pid:19008]
        34. WirePlumber                         [1.6.8, gizmo@ser9-fedora, pid:19035]
        35. WirePlumber [export]                [1.6.8, gizmo@ser9-fedora, pid:19035]
        36. easyeffects                         [1.6.8, gizmo@ser9-fedora, pid:19202]
       147. xdg-desktop-portal                  [1.6.8, gizmo@ser9-fedora, pid:19572]
       148. xdg-desktop-portal-hyprland         [1.6.8, gizmo@ser9-fedora, pid:19698]
       149. pipewire                            [1.6.8, gizmo@ser9-fedora, pid:19755]
       150. waybar                              [1.6.8, gizmo@ser9-fedora, pid:19196]
       151. Blueman                             [1.6.8, gizmo@ser9-fedora, pid:19552]
       152. PulseAudio Volume Control           [1.6.8, gizmo@ser9-fedora, pid:19201]
       153. Google Chrome input                 [1.6.8, gizmo@ser9-fedora, pid:21472]
       154. wpctl                               [1.6.8, gizmo@ser9-fedora, pid:35778]
       155. libcanberra                         [1.6.8, gizmo@ser9-fedora, pid:19201]
       156. Google Chrome                       [1.6.8, gizmo@ser9-fedora, pid:21472]

Audio
 ├─ Devices:
 │      46. Radeon High Definition Audio Controller [alsa]
 │      47. POROSVOC                            [alsa]
 │      48. Ryzen HD Audio Controller           [alsa]
 │      49. RØDE NT-USB Mini                   [alsa]
 │      50. OBSBOT Tiny SE                      [alsa]
 │  
 ├─ Sinks:
 │      44. Easy Effects Sink                   [vol: 0.37]
 │      77. Radeon High Definition Audio Controller HDMI / DisplayPort 4 Output [vol: 1.00]
 │      78. Radeon High Definition Audio Controller HDMI / DisplayPort 3 Output [vol: 1.00]
 │      79. Radeon High Definition Audio Controller HDMI / DisplayPort 2 Output [vol: 1.00]
 │  *   80. Radeon High Definition Audio Controller HDMI / DisplayPort 1 Output [vol: 1.00]
 │      85. Ryzen HD Audio Controller Speaker   [vol: 0.99]
 │      88. RØDE NT-USB Mini Analog Stereo     [vol: 0.79]
 │  
 ├─ Sources:
 │      45. Easy Effects Source                 [vol: 1.00]
 │      83. POROSVOC Mono                       [vol: 1.00]
 │      86. Ryzen HD Audio Controller Front Stereo Microphone [vol: 1.00]
 │      87. Ryzen HD Audio Controller Digital Microphone [vol: 1.00]
 │      89. RØDE NT-USB Mini Mono              [vol: 0.64]
 │  *   90. OBSBOT Tiny SE Analog Stereo        [vol: 1.00]
 │  
 ├─ Filters:
 │  
 └─ Streams:
       160. PulseAudio Volume Control                                   
            178. input_FL        < Easy Effects Source:capture_FL	[active]
            179. input_FR        < Easy Effects Source:capture_FR	[active]
            180. monitor_FL     
            181. monitor_FR     
       161. PulseAudio Volume Control                                   
            208. input_MONO      < POROSVOC:capture_MONO	[active]
            209. monitor_MONO   
       162. PulseAudio Volume Control                                   
            217. input_FL        < ALC897 Analog:capture_FL	[active]
            218. input_FR        < ALC897 Analog:capture_FR	[active]
            219. monitor_FL     
            220. monitor_FR     
       163. PulseAudio Volume Control                                   
            223. input_FL        < Digital Microphone:capture_FL	[active]
            224. input_FR        < Digital Microphone:capture_FR	[active]
            225. monitor_FL     
            226. monitor_FR     
       164. PulseAudio Volume Control                                   
            235. input_MONO      < RØDE NT-USB Mini:capture_MONO	[active]
            236. monitor_MONO   
       165. PulseAudio Volume Control                                   
            238. input_FL        < OBSBOT Tiny SE:capture_FL	[active]
            239. input_FR        < OBSBOT Tiny SE:capture_FR	[active]
            240. monitor_FL     
            241. monitor_FR     
       166. PulseAudio Volume Control                                   
            163. input_FL        < Google Chrome:output_FL	[active]
            164. monitor_FR     
            165. input_FR        < Google Chrome:output_FR	[active]
            166. monitor_FL     
       167. Google Chrome                                               
            164. output_FR       > Easy Effects Sink:playback_FR	[active]
            165. output_FL       > PulseAudio Volume Control:input_FL	[active]

Video
 ├─ Devices:
 │      81. OBSBOT Tiny SE                      [v4l2]
 │      82. OBSBOT Tiny SE                      [v4l2]
 │      84. OBSBOT Tiny SE: OBSBOT Tiny SE      [libcamera]
 │  
 ├─ Sinks:
 │  
 ├─ Sources:
 │  *  244. OBSBOT Tiny SE (V4L2)              
 │  
 ├─ Filters:
 │  
 └─ Streams:

Settings
 └─ Default Configured Devices:
         0. Audio/Sink    alsa_output.pci-0000_64_00.1.HiFi__HDMI1__sink


YouTube Music / Chrome
        │
        ▼
 Easy Effects Sink
        │
        ▼
 Combined Output
       / \
      /   \
 HDMI/DP   Speakers

```