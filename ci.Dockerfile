FROM alpine:3.21.3
RUN apk add --no-cache curl git

ARG DETERMINATE_VERSION=v3.1.1
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/${DETERMINATE_VERSION} | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

ARG DEVBOX_VERSION=0.14.2
RUN nix profile install github:jetify-com/devbox/${DEVBOX_VERSION}

# Uncomment the following line to copy a flox/devbox files into the container
COPY devbox.json devbox.lock devbox/ ./
