#!/bin/sh

REPO_PATH="/root/ceph/git-ceph-deploy/ceph-deploy /root/ceph/git-ceph/ceph"

for repo in $REPO_PATH; do
    cd $repo
    git fetch upstream
    git submodule update --init --recursive
    git checkout master
    git rebase upstream/master
    git push
    echo "------------------------------"
    echo "repo update successed!"
    echo "------------------------------"
done
