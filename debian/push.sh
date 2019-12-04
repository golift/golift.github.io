#!/bin/bash

FILES=../unifi-poller/
CODES="bionic bullseye buster focal jessie lenny precise squeeze stretch trusty wheezy xenial"

for code in ${CODES}; do
  cat << EOF
Origin: Go Lift
Label: Go Lift
Codename: ${code}
Architectures: i386 amd64 armhf arm64
Components: main unstable
Description: Go Lift Apt Repository
SignWith: 616A79D1ADA2F0FD6F5E2A9166AB29F0EC5718FF

EOF
done > conf/distributions

for code in ${CODES}; do
  for deb in ${FILES}/*.deb; do
    reprepro -b . -C unstable includedeb ${code} ${deb}
  done
  if [ "$STABLE" == "" ]; then
    continue
  fi
  for deb in ${STABLE}/*.deb; do
    reprepro -b . -C main includedeb ${code} ${deb}
  done
done
