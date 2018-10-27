#!/usr/bin/python3
"""This module contains the class `VimCustomizer` and the function `main`."""


import argparse as ap
import pathlib as pl
import shutil as su
import subprocess as sp
import typing as ty


class VimCustomizer(object):
    """Configures Vim.

    Method:
        configure
    """

    _VIMRC = '.vimrc'
    _VIM_DIR = '.vim'
    _PYTHON_FILE_TYPE_FILE = 'python.vim'
    _START_DIR = pl.Path('pack/singles/start')
    _URL_START = 'https://github.com/'
    _CLONE_COMMAND_START = ('git', 'clone', '--recursive')
    _GENERATE_HELP_TAGS = ('vim', '-c', 'helptags ALL', '-c', 'q')

    def __init__(self, plugin_paths: ty.Iterable[pl.Path]) -> None:
        """Initialize an instance of this class.

        Arg:
            plugin_paths: Paths to Vim plugins on GitHub.
        """
        self._home_dir = pl.Path.home()
        self._repo_dir = pl.Path.cwd()
        self._home_vim_dir = self._home_dir / self._VIM_DIR
        self._plugin_paths = plugin_paths

    def configure(self) -> None:
        """Set up the user's Vim configuration.

        Execute this function inside the directory `config`.
        """
        self._copy_repo_files()
        self._install_plugins()

    def _copy_repo_files(self) -> None:
        """Copy files from this Git repository to the user's home directory.

        Do not overwrite any previously-existing files.
        """
        repo_vimrc = self._repo_dir / self._VIMRC
        self._copy_if_not_exists(repo_vimrc, self._home_dir)
        self._home_vim_dir.mkdir(exist_ok=True)
        repo_python_file_type_file = (
            self._repo_dir / self._VIM_DIR / self._PYTHON_FILE_TYPE_FILE
        )
        self._copy_if_not_exists(
            repo_python_file_type_file,
            self._home_vim_dir
        )

    def _install_plugins(self) -> None:
        """Install the plugins."""
        start_dir = self._home_vim_dir / self._START_DIR
        start_dir.mkdir(parents=True, exist_ok=True)
        for plugin_path in self._plugin_paths:
            destination_dir = start_dir / plugin_path.stem
            if not destination_dir.exists():
                url = self._URL_START + str(plugin_path)
                clone_command = self._CLONE_COMMAND_START + (url,)
                sp.run(clone_command, cwd=start_dir)
        sp.run(self._GENERATE_HELP_TAGS)

    @staticmethod
    def _copy_if_not_exists(source: pl.Path, destination: pl.Path) -> None:
        """Copy a file if the destination file does not already exist.

        Args:
            source: A file whose contents to copy.
            destination: A location for the copied contents.
        """
        if destination.is_dir():
            destination_file = destination / source.name
        else:
            destination_file = destination
        if not destination_file.exists():
            su.copy(source, destination)


def main():
    """Execute this script's main functionality."""
    parser = ap.ArgumentParser()
    parser.add_argument(
        'plugins_file',
        type=ap.FileType(),
        help='file holding paths to plugins on GitHub'
    )
    args = parser.parse_args()
    contents = args.plugins_file.read()
    raw_path_list = contents.split('\n')
    path_list = (pl.Path(raw_path) for raw_path in raw_path_list)
    customizer = VimCustomizer(path_list)
    customizer.configure()


if __name__ == '__main__':
    main()
