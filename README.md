A Docker image that builds your Qt apps statically.

## Versions

This image is built for supported versions of Ubuntu, you can use
these tags currently:

- `latest` - built from current master, can contain code that
is not yet tested
- `16.04` - built from Ubuntu Xenial
- `18.04` - built from Ubuntu Bionic

## Usage

Change into the directory that your project is in and run
`docker run --rm -it -v $(pwd):/app rikudousage/qt-static:16.04`.

This will create a new container that will be removed once you
exit from it and will link the current directory to the container
under the directory /app. The next step is to go to the directory
(`cd /app`) and build your app.

If you want to build the app without needing to manually issue
commands once inside the docker container, you can supply the 
command with `-c` flag.

Example:

`docker run --rm -it -v $(pwd):/app rikudousage/qt-static:16.04 -c
"cd /app && qmake && make"`.

The image contains statically compiled version of Qt 5.9.0 without
ICU support.
