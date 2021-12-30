# pyenvs.sh

Manage Python virtual environments.


## Installation

Clone this repository with:

```bash
git clone https://github.com/audeering/pyenvs.sh.git ~/git/pyenvs.sh
```

Replace `~/git/pyenvs.sh` with your desired directory.

In order to use it you have to source it:

```bash
source ~/git/pyenvs.sh/pyenvs.sh
```

The best way to make this permanent
is to add the following lines to your `~/.bashrc` file.

```bash
source ${HOME}/git/pyenvs.sh/pyenvs.sh
```


## Usage

Manage python virtual environments with `virtualenv` in the folder
`$HOME/.envs`.

Usage:

```bash
envs location            # dir where environments are stored
create env_name1         # create `env_name1` with default Python version
                         # and activate it
deactivate               # deactivate the current active environment
create env_name2 3.8     # create `env_name2` with python3.8 and activate it
deactivate               # deactivate the current active environment
envs                     # list available environments
envs size                # disk size of environments
activate env_name        # activate virtual environment `env_name`
deactivate               # deactivate the current active environment
delete env_name          # delete virtual environment `env_name`
envs                     # list available environments
```

You can change the folder where the environments are stored
or the default Python version
by exporting the following variables:

```bash
export PYENVS_DIR="${HOME}/.envs"
export PYENVS_PYTHON_VERSION="3"
```

You can also make those settings permanent
by adding them to your `~/.bashrc` file.
