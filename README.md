A Docker image that builds your Qt apps statically.

## Versions

All images are created using LTS versions of Ubuntu.
Generally speaking, Qt versions that support libssl 1.0
are built on 16.04 (xenial), those that support libssl 1.1
are built on 18.04 (bionic), starting from version 5.15 20.04 (focal) is used.

Only currently supported Qt versions are updated.

- `latest` - the latest version of Qt available

- `5.12` - latest 5.12.x version available (Bionic)
- `5.15` - latest 5.15.x version available (Focal)

- `5.12.0`
- `5.12.1`
- `5.12.2`
- `5.12.3` - Last Ubuntu Xenial version
- `5.12.4` - First Ubuntu Bionic version
- `5.12.5`
- `5.12.6`
- `5.12.7`
- `5.12.8`
- `5.12.9` - Last Ubuntu Bionic version
- `5.15.0` - First Ubuntu Focal version
- `5.15.1`
- `5.15.2`

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


