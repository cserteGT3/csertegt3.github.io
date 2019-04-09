---
layout: post
title: How to setup youtube-dl?
description: "Setup youtube-dl on windows."
modified: 2019-04-09
tags: [yt-download, opensource]
categories: [tools]
---
This post is on installing the [youtube-dl](https://github.com/ytdl-org/youtube-dl/) tool on a Windows computer.

## Download

The [installation instructions](https://github.com/ytdl-org/youtube-dl/) are pretty straightforward.
For windows you can download the [latest](https://yt-dl.org/latest/youtube-dl.exe), or search for what you want at the [download page](https://ytdl-org.github.io/youtube-dl/download.html).

## Place and PATH it

Again, check the installation instructions, but `C:\Users\username\yt-dl` is for example a good place for the `.exe` file.
Put that folder into your PATH variable (usually in your own user's PATH).
In english search for the term: `windows path variable`, in hungarian: `windows path környezeti változó`.
At this point the following should work (of course with your installed version):
```console
C:\Users\username\youtube-dl --version
2019.02.18
```
If this works, you have succesfully installed youtube-dl.

## Useful batch files

The following commands are useful (for me at least).
These are for windows.
Create a new textfile and rename it to `something.bat`.
Tested only with youtube.

### download-audio.bat

Download the video and extract the audio to mp3 (best quality).
Video file is deleted afterward.
```
@echo off

set /P dl=YouTube URL:

youtube-dl --extract-audio --audio-format mp3 --audio-quality 0  %dl%

pause
```

### download-audio-keepvid.bat

Download the video and extract the audio to mp3 (best quality).
Keep the original video.

```
@echo off

set /P dl=YouTube URL:

youtube-dl --keep-video --extract-audio --audio-format mp3 --audio-quality 0  %dl%

pause
```

### download-video-1080p.bat

Download the best resolution, but 1920×1080p maximum.

```
@echo off

set /P dl=YouTube URL:

youtube-dl -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" %dl%

pause
```

### download-video-fullres.bat

Download the video at the best available resolution.

```
@echo off

set /P dl=YouTube URL:

youtube-dl %dl%

pause
```
