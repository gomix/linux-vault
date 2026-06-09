# Installing

RHEL 9.8
```
$ sudo subscription-manager repos --enable=rhel-9-for-x86_64-extensions-rpms
$ sudo dnf install goose goose-redhat
```

# First  Impressions
```
# goose --version
 1.23.2

# goose configure  

This will update your existing config files
  if you prefer, you can edit them directly at /root/.config/goose

┌   goose-configure 
│
◆  What would you like to configure?
│  ● Configure Providers (Change provider or update credentials)
│  ○ Custom Providers 
│  ○ Add Extension 
│  ○ Toggle Extensions 
│  ○ Remove Extension 
│  ○ goose settings 
└  
```

> First stop, `goose` does not bring any model, you need to connect to one.

References
* https://access.redhat.com/articles/7142302
* https://goose-docs.ai/