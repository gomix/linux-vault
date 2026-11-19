---
tags:
  - linux
  - cli
  - google-workspace
  - automation
---

# Google Workspace CLI (gws)

`gws` is a command-line client for Google Workspace APIs, including Drive, Sheets, Docs, Slides, Gmail, and Calendar. It returns structured JSON, which makes it useful for inspecting API responses and scripting with Bash and `jq`. The project is under active development and carries no official Google product support.

## Install on Fedora

With Node.js 18 or later and a user-writable npm global prefix:

```bash
npm install -g @googleworkspace/cli
gws --help
```

You can also download a prebuilt Linux binary for your architecture from [GitHub Releases](https://github.com/googleworkspace/cli/releases) and put it on your `PATH`. Install `jq` with `sudo dnf install jq` if needed.

## Authenticate with OAuth

If `gcloud` is installed and authenticated, run `gws auth setup` for the initial Google Cloud project and OAuth setup. For a later sign-in or to select different permissions, run `gws auth login`.

If you already manage a Google Cloud project, follow the [manual OAuth setup](https://github.com/googleworkspace/cli#manual-oauth-setup) to configure a desktop OAuth client and enable the APIs you plan to call. Start with read-only scopes for the examples below. A managed Workspace account may require administrator approval.

## List files in Drive

```bash
gws drive files list \
  --params '{"pageSize":5,"q":"trashed = false","fields":"files(id,name,mimeType)"}' \
  | jq -r '.files[] | [.name, .id, .mimeType] | @tsv'
```

This returns up to five files from the first page and prints the name, Drive ID, and MIME type as tab-separated columns.

## Get slide IDs from a presentation

Take the presentation ID from the URL segment after `/presentation/d/` and substitute it below. The output shows the one-based slide number and the slide's `objectId`.

```bash
gws slides presentations get \
  --params '{"presentationId":"YOUR_PRESENTATION_ID","fields":"slides(objectId)"}' \
  | jq -r '.slides | to_entries[] | [(.key + 1), .value.objectId] | @tsv'
```

For a QSR workflow that clones a template and inserts Sheets charts, query the cloned presentation to confirm the target slide ID. Use that slide ID as `elementProperties.pageObjectId` in the Slides API request from n8n.

## Discover commands

```bash
gws drive files list --help
gws schema drive.files.list
gws schema slides.presentations.get
```

The general pattern is `gws <service> <resource> <method>`. Use `--params` for path and query parameters and `--json` for the request body. Use `--dry-run` to preview a request before executing it.

[CLI command and authentication reference](https://github.com/googleworkspace/cli)  
[Google Workspace API documentation](https://developers.google.com/workspace)
