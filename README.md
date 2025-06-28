# Uiuautils

### "We have [uutils](https://github.com/uutils/coreutils) at home"

[Uiua](https://www.uiua.org/) is a fun language where instead of variables and control flow, you use a global stack and array operations.

I really like wacky languages, so I decided that I wanted to make something cool with uiua, and what better than a reimplementation of some coreutils.

The main challenge with this project was implementing command line arg parsing, a major component for all other programs.

## How do I run this?

You can either install uiua manually or use the provided nix flake via `nix develop`

You can use `uiua <program>.ua` to run a program, or `uiua build <program>.ua` to compile a standalone binary
