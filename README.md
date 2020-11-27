# Tectonic + Biber GitHub Action

A GitHub Action which compiles a LaTeX document using [Tectonic](https://tectonic-typesetting.github.io/en-US/) and [Biber](http://biblatex-biber.sourceforge.net/).

Big thanks to Wtfjoke for [the Docker image](https://hub.docker.com/r/dxjoke/tectonic-docker) used by this action. Action structure is largely based on [latex-action](https://github.com/xu-cheng/latex-action).

## Inputs

| Key                   | Default                                 | Description                                                                 |
|-----------------------|-----------------------------------------|-----------------------------------------------------------------------------|
| **files**             | *Required*                              | The LaTeX files to compile                                                  |
| **tectonic_args**     |                                         | Arguments to pass to Tectonic when compiling                                |
| **biber_args**        |                                         | Arguments to pass to the Biber engine when compiling                        |
| **tectonic_args_pre** | --keep-intermediates --reruns 0         | Arguments to pass to Tectonic when compiling the .bcf, before running Biber |

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

## Comparison to [vinay0410/tectonic-action](https://github.com/vinay0410/tectonic-action)

This action was primarily created because the existing GitHub Action doesn't support Biber (support for which isn't native to Tectonic yet, see [tectonic#35](https://github.com/tectonic-typesetting/tectonic/issues/35)).

Keep in mind that this is a complete rewrite though, which means that it is made with slightly different design decisions. For example, pushing compiled files is not built into this action. This action is focused solely on compiling LaTeX files, and doing so in a fully customizable way. Everything else that may be needed is left for other actions to handle, e.g. [actions/upload-artifact](https://github.com/actions/upload-artifact)
