FROM archimg/base

# Add packages to allow compilation of clang and llvm
RUN pacman -Syu --noconfirm \
  bash-completion \
  clang \
  cmake \
  gdb \
  git \
  lld \
  make \
  ninja \
  nodejs \
  python \
  sudo \
  vim \
  wget \
  zlib

# Remove gcc and g++.
# Symlink cc and c++ to clang
RUN \
 rm /usr/bin/gcc* \
 && rm /usr/bin/g++ \
 && ln -sfn /usr/bin/clang /usr/bin/cc \
 && ln -sfn /usr/bin/clang++ /usr/bin/c++

USER root
WORKDIR /home/root

CMD \
 git clone https://github.com/winksaville/explore-cpp-lld-static-link-bug lld-bug \
 && cd lld-bug \
 && make run-gold \
 && make run-lld
