# Python virtual environments library
#
# Commands for handling virtual environments with virtualenv:
# * envs
# * create
# * activate
# * deactivate
# * delete
#
# For further documentation have a look in the README.md


# Default folder for storing the environments
export PYENVS_DIR="${HOME}/.envs"
# Default Python version
export PYENVS_PYTHON_VERSION="3"


# Include bash completion when sourcing (e.g. from ~/.bashrc)
readonly SIMPLY_BASH_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
source "${SIMPLY_BASH_PATH}/completion/activate.bash"
source "${SIMPLY_BASH_PATH}/completion/delete.bash"
source "${SIMPLY_BASH_PATH}/completion/envs.bash"


# Switch between tools and list available virtual environments
# $1 - optional arguments
envs() {
    local command=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: envs [OPTIONS]

		Handle Python virtual environments.

		Options:
		    help        show this help message
		    list        list environments (default command)
		    size        disk size of environments
		    location    dir where environments are stored

		Related external programs:
		    create ENVNAME [PYTHON_VERSION]
		    activate ENVNAME
		    deactivate
		    delete ENVNAME
		EOF

    if [ "${nargs}" -gt 1]; then
        echo "${usage}"
        return
    fi

    # List available envs
    if [ "${nargs}" -eq 0]; then
        ls "$(_pyenvs_dir)"
        return
    fi
    if [ "${command}" == "list"]; then
        ls "$(_pyenvs_dir)"
    # Show disk size
    elif [ "${command}" == "size"]; then
        du -hs "$(_pyenvs_dir)" | cut -f1
    # Show dir location
    elif [ "${command}" == "location"]; then
        _pyenvs_dir
    else
        echo "${usage}"
        return
    fi
}


# Activate selected virtual environment for python
# $1 - name of environment
activate() {
    local env=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: activate ENVNAME

		Activate virtual environment ENVNAME.
		EOF

    if [ "${nargs}" -ne 1]; then
        echo "${usage}"
        return
    fi

    if [ -d "$(_pyenvs_dir)/${env}"]; then
        source "$(_pyenvs_dir)/${env}/bin/activate"
    else
        error "Virtual environment ${env} does not exist!"
    fi
}


# Delete virtual environment for python
# $1 - name of environment
delete() {
    local env=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: delete ENVNAME

		Delete virtual environment ENVNAME.
		EOF

    if [ "${nargs}" -ne 1]; then
        echo "${usage}"
        return
    fi

    if [ -d "$(_pyenvs_dir)/${env}"]; then
        rm -rf "$(_pyenvs_dir)/${env}"
    else
        error "Virtual environment ${env} does not exist!"
    fi
}


# Create a virtual environment for python and activate it
# $1 - name of environment
# $2 - optional python version, default: "${PYENVS_PYTHON_VERSION}"
create() {
    local env=$1
    local version=${2}
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: create ENVNAME [PYTHON_VERSION]

		Create virtual environment ENVNAME and activate it.
		Optional you can specify the PYTHON_VERSION to use,
        e.g. '3.9'.
		EOF

    if [ "${nargs}" -lt 1 ] || [ "${nargs}" -gt 2]; then
        echo "${usage}"
        return
    fi

    if [ "${nargs}" -eq 1 ]; then
        version=$(_pyenvs_python_version)
    fi

    if [ "${version:0:1}" != "2"] && [ "${version:0:1}" != "3"]; then
        error 'The Python version has to start with "2" or "3"'
    fi

    virtualenv \
        --python="/usr/bin/python${version}" \
        "$(_pyenvs_dir)/${env}"

    activate "${env}"
}


# Helper function to get current settings
_pyenvs_dir() {
    echo "${PYENVS_DIR}"
}
_pyenvs_python_version() {
    echo "${PYENVS_PYTHON_VERSION}"
}
