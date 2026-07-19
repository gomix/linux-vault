# Zstandard (zstd)

## Overview

**Zstandard (zstd)** is a fast, modern lossless compression algorithm developed by Facebook (Meta). It provides high compression ratios while maintaining excellent compression and decompression speeds, making it a popular choice for backups, archives, and Linux distributions.

## Examples

### Compress a file

```bash
zstd large-file.log
```

Output:

```text
large-file.log.zst
```

### Decompress a file

```bash
zstd -d large-file.log.zst
```

or

```bash
unzstd large-file.log.zst
```