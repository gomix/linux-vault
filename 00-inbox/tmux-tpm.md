# Tmux Plugin Manager (TPM)

Install TPM

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Configure your plugins:
```
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'


# plugins configuration
set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'
set -g @resurrect-save-bash-history 'on'
set -g @resurrect-capture-pane-contents 'on'
```
And at very end of the configuration file add:
```
# Initialize TMUX plugin manager 
# (keep this line at the very bottom of your mux.conf)
run -b '~/.tmux/plugins/tpm/tpm'
```
Inside `tmux` install your plugins
```
Prefix + I
```
In my case `Ctrl - j - I` , capital "i".