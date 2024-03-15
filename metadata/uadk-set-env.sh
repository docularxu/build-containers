#!/bin/bash
#
# Readme: 1) This file is supposed to be executed inside of a docker container.
#         2) It sets up environment variables for UADK.       
#         3) Refer to <https://gitee.com/docularxu/uadk-bigdata/blob/master/uadk.md> for more details.
#
# Exectution:
#         inside a docker container, run it with '.' environment.
#         $ . ./uadk-set-env.sh
#

set -x

# enable HiSilicon accelerator devices read/write permission
sudo chmod 666 /dev/hisi_*

# enable logging through rsyslog
sudo /usr/sbin/rsyslogd || true

# set Library path
export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

# set queue number
export WD_RSA_CTX_NUM="sync:2@0,async:4@0"
export WD_DH_CTX_NUM="sync:2@0,async:4@0"
export WD_CIPHER_CTX_NUM="sync:2@2,async:4@2"
export WD_DIGEST_CTX_NUM="sync:2@2,async:4@2" # set Async mode
export WD_CIPHER_EPOLL_EN=1
export WD_AEAD_EPOLL_EN=1
export WD_DIGEST_EPOLL_EN=1
export WD_DH_EPOLL_EN=1
export WD_RSA_EPOLL_EN=1
export WD_ECC_EPOLL_EN=1
export WD_COMP_EPOLL_EN=1
