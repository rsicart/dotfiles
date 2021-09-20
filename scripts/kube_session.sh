#!/usr/bin/env bash

function kube-session {
    KUBECONFIG_TMP_PATH="$HOME/.kube/tmp"
    mkdir -p $KUBECONFIG_TMP_PATH
    chmod 700 $KUBECONFIG_TMP_PATH
    chmod 600 $KUBECONFIG_TMP_PATH/*
    # clean tmp folder
    find $KUBECONFIG_TMP_PATH -type f -mtime +90 -name "config.*" -delete
    # create kubeconfig file for session
    KUBECONFIG_FILENAME=$KUBECONFIG_TMP_PATH/config.$(date +%s)
    cp ~/.kube/config $KUBECONFIG_FILENAME
    export KUBECONFIG=$KUBECONFIG_FILENAME
    echo "kubeconfig file configured to '${KUBECONFIG_FILENAME}'!"
}
