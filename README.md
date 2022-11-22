# pyenvs.sh

Manage Python virtual environments.


## Installation

Clone the repository to `~/git/pyenvs.sh`
or another desired directory:

```bash
git clone https://github.com/audeering/pyenvs.sh.git ~/git/pyenvs.sh
```

Source the file `pyenvs.sh` to use.
To make it permanent,
add the following lines to your `~/.bashrc` file.

```bash
source ${HOME}/git/pyenvs.sh/pyenvs.sh
```


## Usage

**pyenvs.sh** provides the commands
`create`,
`activate`,
`delete`,
`envs`
to manage virtual environments with `virtualenv`.
It deals easily with a large number of environments
by automatic tab completion.

```bash
envs location            # dir where environments are stored
create env_name1         # create `env_name1` with default Python version
                         # and activate it
deactivate               # deactivate the current active environment
create env_name2 3.8     # create `env_name2` with python3.8 and activate it
deactivate               # deactivate the current active environment
envs                     # list available environments
envs size                # disk size of environments
activate env_name1       # activate virtual environment `env_name1`
deactivate               # deactivate the current active environment
delete env_name1         # delete virtual environment `env_name1`
```

You can change the folder
where the environments are stored
or the default Python version
by exporting
`PYENVS_DIR`
and `PYENVS_PYTHON_VERSION`.
It's default values are:

```bash
export PYENVS_DIR="${HOME}/.envs"
export PYENVS_PYTHON_VERSION="3"
```

You can make your settings permanent
by adding them to your `~/.bashrc` file.


### Install different Python versions

As shown above
you can specify the Python version to use
for every virtual environment.
To see which Python versions are available on your system
you can run

```bash
$ ls -1 -d -- /usr/bin/python[0-9]\.[0-9]
/usr/bin/python2.7
/usr/bin/python3.6
/usr/bin/python3.7
/usr/bin/python3.8
```

To install a missing version under Ubuntu
you can use the [deadsnakes
PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa).

```bash
$ sudo add-apt-repository ppa:deadsnakes/ppa
$ sudo apt update && sudo apt upgrade
$ $ sudo apt install python3.9
```
