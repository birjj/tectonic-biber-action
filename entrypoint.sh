#!/usr/bin/env bash

# utility functions
set -e
info() {
    echo -e "\033[1;34m1$1\033[0m"
}
warn() {
    echo "::warning :: $1"
}
error() {
    echo "::error :: $1"
    exit 1
}

files="$INPUT_FILES"
tectonic_pre_args="$INPUT_TECTONIC_PRE_ARGS"
biber_args="$INPUT_TECTONIC_BIBER_ARGS"
tectonic_args="$INPUT_TECTONIC_ARGS"

# check that input is valid
if [[ -z "$files" ]]; then
    error "Input files are missing."
fi
if [[ -z "$tectonic_pre_args" ]]; then
    tectonic_pre_args="--keep-intermediates --reruns 0"
fi

# execute on all files
while IFS= read -r f; do
    # make sure we have a file to compile
    if [[ -z "$f" ]]; then
        continue
    fi
    if [[ ! -f "$f" ]]; then
        error "File '$f' cannot be found from '$PWD'."
    fi

    # finally compile
    target="${f%.*}"
    info "Compiling $target"
    tectonic $tectonic_pre_args $target.tex
    if [[ -f "$target.bcf" ]]; then
        biber $biber_args $target
    else
        info "No .bcf file found; skipping biber"
    fi
    tectonic $tectonic_args $target.tex
done <<< "$files"