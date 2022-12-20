####
#### Dockerfile C++ from microsoft 
####
# See: https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/introduction-to-dev-containers#creating-a-custom-dev-container-configuration

# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.233.0/containers/cpp/.devcontainer/base.Dockerfile

# [Choice] Debian / Ubuntu version (use Debian 11, Ubuntu 18.04/22.04 on local arm64/Apple Silicon): debian-11, debian-10, ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT}

# [Optional] Install CMake version different from what base image has already installed. 
# CMake reinstall choices: none, 3.21.5, 3.22.2, or versions from https://cmake.org/download/
ARG REINSTALL_CMAKE_VERSION_FROM_SOURCE="none"

# Optionally install the cmake for vcpkg
COPY ./reinstall-cmake.sh /tmp/
RUN if [ "${REINSTALL_CMAKE_VERSION_FROM_SOURCE}" != "none" ]; then \
        chmod +x /tmp/reinstall-cmake.sh && /tmp/reinstall-cmake.sh ${REINSTALL_CMAKE_VERSION_FROM_SOURCE}; \
    fi \
    && rm -f /tmp/reinstall-cmake.sh

# [Optional] Uncomment this section to install additional vcpkg ports.
# RUN su vscode -c "${VCPKG_ROOT}/vcpkg install <your-port-name-here>"

####
#### Dockerfile from foundation-developer 
####

# make it fresh
# add en UTF-8 as a locale
ENV OTHER_PROJECTS \
mulle-sde/mulle-sde-developer; \
mulle-c/mulle-c-developer; \
mulle-objc/mulle-objc-developer; \
MulleFoundation/mulle-foundation-developer; \
MulleFoundation/foundation-developer;

ENV SDE_PROJECTS    mulle-test


RUN DEBIAN_FRONTEND=noninteractive \
      apt-get update \
   && apt-get -y install cmake curl git ninja-build build-essential uuid-runtime bsdmainutils wget \
                         libncursesw6 libsource-highlight4v5 \
   && wget "https://raw.githubusercontent.com/mulle-sde/mulle-sde/prerelease/bin/installer-all" \
   && chmod 755 installer-all \
   && ./installer-all /usr no 

RUN wget "https://github.com/mulle-cc/mulle-clang-project/releases/download/14.0.6.2/mulle-clang-14.0.6.2-bullseye-amd64.deb"  \
    && dpkg --install "mulle-clang-14.0.6.2-bullseye-amd64.deb"

# remove original gdb from c++, need to do this as mulle-gdb clobbers some helper files
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get -y remove gdb
   
RUN wget "https://github.com/mulle-cc/mulle-gdb/releases/download/11.1.0.0/mulle-gdb_11.1.0-1_bullseye_amd64.deb"  \
    && dpkg --install "mulle-gdb_11.1.0-1_bullseye_amd64.deb" \
    && ln -s /opt/mulle-gdb/11.1.0.1/bin/mulle-gdbserver /usr/bin \
    && ln -s /opt/mulle-gdb/11.1.0.1/bin/mulle-gdb /usr/bin
