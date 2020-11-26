# Tectonic + Biber GitHub Action

A GitHub Action which compiles a LaTeX document using [Tectonic](https://tectonic-typesetting.github.io/en-US/) and [Biber](http://biblatex-biber.sourceforge.net/).

Big thanks to Wtfjoke for [the Docker image](https://hub.docker.com/r/dxjoke/tectonic-docker) used by this action. Action structure is largely based on [latex-action](https://github.com/xu-cheng/latex-action).

## Examples

### Compile files and upload them as artifacts

```yml
name: My action
on: [push, pull_request]
jobs:
  compile_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2
      - name: Compile
        uses: birjolaxew/tectonic-biber-action@master
        with:
          files: |
            my/file1.tex
            file2.tex
      - name: Upload PDF
        uses: actions/upload-artifact@master
        with:
          name: pdf
          path: |
            my/file1.pdf
            file2.pdf
```
