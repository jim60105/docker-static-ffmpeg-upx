# docker-static-ffmpeg-upx

[![CodeFactor](https://www.codefactor.io/repository/github/jim60105/docker-static-ffmpeg-upx/badge)](https://www.codefactor.io/repository/github/jim60105/docker-static-ffmpeg-upx) [![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/jim60105/docker-static-ffmpeg-upx/scan.yml?label=IMAGE%20SCAN)](https://github.com/jim60105/docker-static-ffmpeg-upx/actions/workflows/scan.yml)

This is the [wader/static-ffmpeg](https://github.com/wader/static-ffmpeg) compressed with upx.

After UPX compression, the size is reduced to about _**26%**_.

I did nothing except compress. I created this image mainly for my other projects that uses static-ffmpeg. Also added the compressed dumb-init since I often use it together.

Thanks for all the great works by [wader/static-ffmpeg](https://github.com/wader/static-ffmpeg). Please refer to his project and my [Dockerfile](/Dockerfile) for all technical information.

## Usage

Get the Dockerfile at [GitHub](https://github.com/jim60105/docker-static-ffmpeg-upx), or pull the image from [ghcr.io](https://ghcr.io/jim60105/static-ffmpeg-upx) or [quay.io](https://quay.io/repository/jim60105/static-ffmpeg-upx?tab=tags).

In Dockerfile

```Dockerfile
COPY --from=jim60105/static-ffmpeg-upx:7.0-1 /ffmpeg /usr/local/bin/
COPY --from=jim60105/static-ffmpeg-upx:7.0-1 /ffprobe /usr/local/bin/
```

Run directly

```sh
docker run -i --rm -u $UID:$GROUPS -v "$PWD:$PWD" -w "$PWD" ghcr.io/jim60105/static-ffmpeg-upx:7.0-1 -i file.wav file.mp3
docker run -i --rm -u $UID:$GROUPS -v "$PWD:$PWD" -w "$PWD" --entrypoint=/ffprobe ghcr.io/jim60105/static-ffmpeg-upx:7.0-1 -i file.wav
```

As shell alias

```sh
alias ffmpeg='docker run -i --rm -u $UID:$GROUPS -v "$PWD:$PWD" -w "$PWD" ghcr.io/jim60105/static-ffmpeg-upx:7.0-1'
alias ffprobe='docker run -i --rm -u $UID:$GROUPS -v "$PWD:$PWD" -w "$PWD" --entrypoint=/ffprobe ghcr.io/jim60105/static-ffmpeg-upx:7.0-1'
```

## LICENSE

> [!NOTE]  
> The main program, [wader/static-ffmpeg](https://github.com/wader/static-ffmpeg), is distributed under [MIT](https://github.com/wader/static-ffmpeg/blob/main/LICENSE).  
> Please consult their repository for access to the source code and licenses.  
> The following is the license for the Dockerfiles and CI workflows in this repository.

The Dockerfile and CI workflow files in this repository are licensed under [the MIT license](LICENSE).
