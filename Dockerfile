FROM debian:buster

# upgrade debian packages
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update
RUN apt-get install apt-utils -y
RUN apt-get upgrade -y


# install dependencies
RUN apt install \
git \
make \
build-essential \
mingw-w64 \
valgrind \
clang-format \
-y

# download source code
WORKDIR /src
RUN git clone  https://github.com/daxxog/buffer-overflow-segfaults.git

# setup entrypoint
WORKDIR /src/buffer-overflow-segfaults
ENTRYPOINT ["/usr/bin/make"]
CMD ["iter"]
