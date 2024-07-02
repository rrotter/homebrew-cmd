# Homebrew Commands

A collection of added commands for [brew](https://github.com/Homebrew/brew).


## Installation

`brew tap rrotter/cmd`

## Commands/Usage

### `brew file`

Open Brewfile for editing. Opens global Brewfile if there is no local/project Brewfile in current directory. See `brew file -h` for further usage info.

### `brew taps`

Print a table summarizing installed taps, including information on the current git status.

Sample output:

```
~ % brew taps
Tap              Size   🍺   🍷 Cmd
homebrew/aliases 268K    0    0   2
homebrew/bundle   15M    0    0   1
homebrew/cask       -    0 6989   0
homebrew/core    678M 7086    0   3
rrotter/cmd      164K    0    0   2 (wip)
rrotter/dev-cmd  8.0K    0    0   1
rrotter/useful    68K    1    0   0
```
