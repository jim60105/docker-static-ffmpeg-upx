# docker-static-ffmpeg-upx

[![CodeFactor](https://www.codefactor.io/repository/github/jim60105/docker-static-ffmpeg-upx/badge)](https://www.codefactor.io/repository/github/jim60105/docker-static-ffmpeg-upx)

This is the [wader/static-ffmpeg](https://github.com/wader/static-ffmpeg) compressed with upx.

After UPX compression, the binary size is reduced to about _**26%**_.

![2024-05-05-182446](https://github.com/jim60105/docker-static-ffmpeg-upx/assets/16995691/bc3f72e9-a2ec-4434-a84d-5c125773f748)

![2024-05-05-182008](https://github.com/jim60105/docker-static-ffmpeg-upx/assets/16995691/52ca035f-2268-4bca-87c5-bc7e74d591ee)

I did nothing except compress. I created this image mainly for my other projects that uses static-ffmpeg. Also added the compressed [dumb-init](https://github.com/Yelp/dumb-init) since I often use it together.

Thanks for all the great works by [wader/static-ffmpeg](https://github.com/wader/static-ffmpeg). Please refer to [his project](https://github.com/wader/static-ffmpeg) and my [Dockerfile](/Dockerfile) for all technical information.

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
> The main program, [wader/static-ffmpeg](https://github.com/wader/static-ffmpeg), is distributed under [MIT](https://github.com/wader/static-ffmpeg/blob/master/LICENSE).  
> Please consult their repository for access to the source code and licenses.  
> The following is the license for the Dockerfiles and CI workflows in this repository.

The Dockerfile and CI workflow files in this repository are licensed under [the MIT license](LICENSE).
