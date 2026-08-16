---
tags:
- text-processing
- cli
---

# grep

`grep` is a command-line tool used to search text for lines that match a given pattern. It is commonly used to filter command output, search files, and inspect logs.

## Basic Usage

``` bash
grep PATTERN FILE
```

Example:

``` bash
grep "error" application.log
```

Search recursively through a directory:

``` bash
grep -r "error" /var/log/
```

Case-insensitive search:

``` bash
grep -i "error" application.log
```

Show line numbers:

``` bash
grep -n "error" application.log
```

## Common Options

  Option   Description
  -------- ----------------------------------
  `-i`     Ignore case
  `-n`     Show line numbers
  `-r`     Search recursively
  `-v`     Show lines that do not match
  `-E`     Use extended regular expressions
  `-w`     Match whole words

