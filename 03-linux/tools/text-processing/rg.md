---
aliases:
  - rg
tags:
  - linux
  - cli
  - text-processing
  - search
---
# ripgrep (rg)

**ripgrep** (`rg`) is a command-line tool for searching text in files and directories. It is a fast alternative to `grep`, with regular expression support and recursive searching enabled by default.

It respects `.gitignore` rules and skips hidden files and binary files by default.

## Basic examples

- `rg 'text'`: search the current directory and its subdirectories.
- `rg -i 'text'`: search without distinguishing uppercase and lowercase.
- `rg -n 'text' file.conf`: display matches with line numbers.
- `rg -l 'text'`: display only the names of files containing matches.
- `rg 'text' -g '*.yaml'`: search only YAML files.
- `rg --hidden 'text'`: include hidden files and directories.
- `rg --files`: list the files that would be searched.

> To search for literal text without interpreting regular expressions, use `rg -F 'text'`.

