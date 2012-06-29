These are the dotfiles I use.

Installation
------------

- Clone the repository into your home directory.
- Move, if it exists and you want to keep your configurations, your current .bash_profile to .bash_profile.local
- Link the .bash_profile to the bash_profile inside the cloned repo (ln -s <CLONED_DIR>/bash/bash_profile .bash_profile)

Dependencies
------------

- It uses the rvm for managing ruby versions
- It uses brew for autocompletion
- It aliases some binaries to shorter names, like git (g), rails (r), bundle (b), vim (vi)
