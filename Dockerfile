# syntax=docker/dockerfile:1
ARG UID=1001
ARG VERSION=latest
ARG RELEASE=0

########################################
# Compress stage
########################################
FROM mwader/static-ffmpeg:$VERSION as ffmpeg

FROM alpine:3.19 as compress

# RUN mount cache for multi-arch: https://github.com/docker/buildx/issues/549#issuecomment-1788297892
ARG TARGETARCH
ARG TARGETVARIANT

# Compress ffmpeg, ffprobe and dumb-init with upx
RUN --mount=type=cache,id=apk-$TARGETARCH$TARGETVARIANT,sharing=locked,target=/var/cache/apk \
    --mount=from=ffmpeg,source=/ffmpeg,target=/tmp/ffmpeg,rw \
    --mount=from=ffmpeg,source=/ffprobe,target=/tmp/ffprobe,rw \
    apk update && apk add -u \
    -X "https://dl-cdn.alpinelinux.org/alpine/edge/community" \
    upx dumb-init && \
    cp /tmp/ffmpeg / && \
    cp /tmp/ffprobe / && \
    #! UPX will skip small files and large files
    # https://github.com/upx/upx/blob/5bef96806860382395d9681f3b0c69e0f7e853cf/src/p_unix.cpp#L80
    # https://github.com/upx/upx/blob/b0dc48316516d236664dfc5f1eb5f2de00fc0799/src/conf.h#L134
    upx --best --lzma /ffmpeg || true; \
    upx --best --lzma /ffprobe || true; \
    upx --best --lzma /usr/bin/dumb-init || true; \
    apk del upx

########################################
# Final stage
########################################
FROM scratch AS final

COPY --link --chown=0:0 --chmod=775 --from=compress /ffmpeg /ffprobe /usr/bin/dumb-init /
COPY --link --chown=0:0 --chmod=775 --from=ffmpeg /versions.json /
COPY --link --chown=0:0 --chmod=775 --from=ffmpeg /doc/* /doc/
COPY --link --chown=0:0 --chmod=775 --from=ffmpeg /etc/ssl/cert.pem /etc/ssl/cert.pem

# Copy licenses (OpenShift Policy)
COPY --link --chown=0:0 --chmod=775 LICENSE /licenses/Dockerfile.LICENSE
COPY --link --chown=0:0 --chmod=775 static-ffmpeg/LICENSE /licenses/static-ffmpeg.LICENSE

STOPSIGNAL SIGINT

# Use dumb-init as PID 1 to handle signals properly
ENTRYPOINT [ "/dumb-init", "--", "/ffmpeg" ]
CMD ["-h"]

ARG VERSION
ARG RELEASE
LABEL name="jim60105/docker-static-ffmpeg-upx" \
    # Author for static-ffmpeg
    vendor="Mattias Wadman" \
    # Maintainer for this docker image
    maintainer="jim60105" \
    # Dockerfile source repository
    url="https://github.com/jim60105/docker-static-ffmpeg-upx" \
    version=${VERSION} \
    # This should be a number, incremented with each change
    release=${RELEASE} \
    io.k8s.display-name="static-ffmpeg" \
    summary="UPX compressed ffmpeg/ffprobe binaries built as hardened static PIE binaries with no external dependencies" \
    description="This is the static-ffmpeg compressed with upx. For more information about this tool, please visit the following website: https://github.com/wader/static-ffmpeg"
