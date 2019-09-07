A Docker image that builds your Qt apps statically.

## Versions

- `latest` - the latest version of Qt available
- `5.9` - latest 5.9.x version available
- `5.12` - latest 5.12.x version available
- `5.13` - latest 5.13.x version available
- `5.9.0` - Ubuntu Xenial
- `5.9.8` - Ubuntu Xenial
- `5.12.0` - Ubuntu Xenial
- `5.13.1` - Ubuntu Bionic

## Usage

Change into the directory that your project is in and run
`docker run --rm -it -v $(pwd):/app rikudousage/qt-static:5.9.0`.

This will create a new container that will be removed once you
exit from it and will link the current directory to the container
under the directory /app. The next step is to go to the directory
(`cd /app`) and build your app.

If you want to build the app without needing to manually issue
commands once inside the docker container, you can supply the 
command with `-c` flag.

Example:

`docker run --rm -it -v $(pwd):/app rikudousage/qt-static:5.9.0 -c
"cd /app && qmake && make"`.

The image contains statically compiled version of Qt 5.9.0 without
ICU support.
