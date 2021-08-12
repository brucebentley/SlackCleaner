<p align="center">
  <a href="https://github.com/brucebentley/SlackCleaner">
    <img src="./logo.png" alt="SlackCleaner" width="200" height="165">
  </a>
</p>

<h1 align="center">SlackCleaner</h1>

Bulk delete messages and files on Slack.

<p align="center">
  <a href="https://github.com/brucebentley/SlackCleaner/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/brucebentley/SlackCleaner" alt="License">
  </a>
  <a href="https://github.com/brucebentley/SlackCleaner/actions">
    <img src="https://github.com/brucebentley/SlackCleaner/actions/workflows/python/badge.svg" alt="Python">
  </a>
  <a href="https://pypi.python.org/pypi/SlackCleaner">
    <img src="https://img.shields.io/pypi/pyversions/SlackCleaner" alt="Python Version(s)">
  </a>
  <a href="https://pypi.python.org/pypi/SlackCleaner">
    <img src="https://img.shields.io/pypi/v/SlackCleaner" alt="PyPi" >
  </a>
  <a href="https://SlackCleaner.readthedocs.io/en/latest/">
    <img src="https://img.shields.io/readthedocs/SlackCleaner/latest" alt="Read the Docs">
  </a>
</p>

## Install

**Install from PyPi:**
```bash
pip install SlackCleaner
```

**Latest Version:**
```bash
pip install -e git+https://github.com/brucebentley/SlackCleaner.git#egg=SlackCleaner
```
## Usage

In contrast to the original version [`slack-cleaner`](https://github.com/kfei/slack-cleaner), this version is a focusing on pure python package that allows for easy scripting instead of a vast amount of different command line arguments.

**Basic Usage:**

```python
from SlackCleaner import *

s = SlackCleaner('SECRET TOKEN')
# list of users
s.users
# list of all kind of channels
s.conversations

# delete all messages in -bots channels
for msg in s.msgs(filter(match('.*-bots'), s.conversations)):
  # delete messages, its files, and all its replies (thread)
  msg.delete(replies=True, files=True)

# delete all general messages and also iterate over all replies
for msg in s.c.general.msgs(with_replies=True):
  msg.delete()
```

[Migration Guides form slack-cleaner](https://github.com/sgratzl/slack-cleaner/issues/79) contains a series of common pattern in slack cleaner and their counterpart in Slack Cleaner2

## Token

The slack cleaner needs you to give Slack's API permission to let it run the operations it needs. You grant these by registering it as an app in the workspace you want to use it in.

You can grant these permissions to the app by:

1. Going to [Your Apps](https://api.slack.com/apps)
2. Select 'Create New App', fill out an App Name _( eg 'Slack Cleaner' )_ and select the Slack workspace you want to use it in
3. Select 'OAuth & Permissions' in the sidebar
4. Scroll down to **User Token Scope** and select all scopes you need according to list below
5. Select 'Save changes'
6. Select 'Install App to Workspace'
7. Review the permissions and press 'Authorize'
8. Copy the 'OAuth Access Token' shown, and use as the first argument to `SlackCleaner`

The token should start with **xoxp** and not like bot tokens with **xoxb**.

Beyond granting permissions, if you wish to use this library to delete messages or files posted by others, you will need to be an [Owner or Admin](https://get.slack.help/hc/en-us/articles/218124397-Change-a-member-s-role) of the workspace.

### User Token Scopes By Use Case

#### General Channel And User Detection

- `users:read`
- `channels:read`
- `groups:read`
- `im:read`
- `mpim:read`

#### Deleting Messages From Public Channels

- `users:read`
- `channels:read`
- `channels:history`
- `chat:write`

#### Deleting Messages From Private Channels

- `users:read`
- `groups:read`
- `groups:history`
- `chat:write`

#### Deleting Messages From 1:1 Ims

> **Note**:  
> You can only delete your own messages, not the ones of others. This is due to a restriction in the Slack API and there is nothing one can do about it.

- `im:read`
- `im:history`
- `users:read`
- `chat:write`

#### Deleting Messages From Multi-Person Ims

- `mpim:read`
- `mpim:history`
- `users:read`
- `chat:write`

#### Deleting Files

- `files:read`
- `users:read`
- `files:write`

### All User Token Scopes

![User token scopes](https://user-images.githubusercontent.com/4129778/81291893-f20b9580-906a-11ea-80a8-f19f3e6878e9.png)

## Docker

There is no direct docker file available, however since it is a python module one can easily create one: 

```py
FROM python:3.7-alpine

LABEL maintainer="Bruce Bentley <brucebentley@me.com>"

VOLUME "/backup"
WORKDIR /backup

RUN pip --no-cache-dir install SlackCleaner

CMD ["python", "-"]
```

An Docker image named  SlackCleaner` with this Dockerfile would be used like

```bash
cat myscript.py | docker run -i SlackCleaner
```

The `myscript.py` file is a python script using the SlackCleaner module.

## Credits

**To all the people who can only afford a free plan. :cry:**


## Development

### Release

```bash
bumpversion patch

git commit -am 'Release vX.X.X'
git tag vX.X.X

invoke release
git push
git push --tags
```

**Change Version In:** `. SlackCleaner/_info.py`
