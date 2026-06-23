# Troubleshooting Fedora with AI

Intro... bla bla.. `goose` + `ramalama` + `Linux MCP Server`.

```
; tools installation
$ sudo dnf install goose ramalama -y

; download and run model (local inference server)
$ ramalama serve qwen2.5:7b
...
$ pip install linux-mcp-server
```
goose config
```
$ cat ~/.config/goose/config.yaml
OPENAI_HOST: http://localhost:8080
OPENAI_BASE_PATH: v1/chat/completions
GOOSE_PROVIDER: openai
GOOSE_MODEL: library/qwen2.5
extensions:
  chatrecall:
    enabled: false
    type: platform
    name: chatrecall
    description: Search past conversations and load session summaries for contextual memory
    display_name: Chat Recall
    bundled: true
    available_tools: []
  extensionmanager:
    enabled: true
    type: platform
    name: Extension Manager
    description: Enable extension management tools for discovering, enabling, and disabling extensions
    display_name: Extension Manager
    bundled: true
    available_tools: []
  skills:
    enabled: true
    type: platform
    name: skills
    description: Load and use skills from relevant directories
    display_name: Skills
    bundled: true
    available_tools: []
  code_execution:
    enabled: false
    type: platform
    name: code_execution
    description: Goose will make extension calls through code execution, saving tokens
    display_name: Code Mode
    bundled: true
    available_tools: []
  todo:
    enabled: true
    type: platform
    name: todo
    description: Enable a todo list for goose so it can keep track of what it is doing
    display_name: Todo
    bundled: true
    available_tools: []
  apps:
    enabled: true
    type: platform
    name: apps
    description: Create and manage custom Goose apps through chat. Apps are HTML/CSS/JavaScript and run in sandboxed windows.
    display_name: Apps
    bundled: true
    available_tools: []
```

```
$ goose session
( O)> qué está ocupando la memoria de mi fedora?
Para verificar qué está ocupando la memoria en tu sistema Fedora, podemos utilizar algunas herramientas comunes como `free`, `top`, `htop`, o `ps`. Estas herramientas nos proporcionarán información detallada sobre el uso de la memoria y los procesos que están consumiendo recursos.
...
```