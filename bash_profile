# .bash_profile: executed by bash(1) for login shells, which may or may not include Terminal.app.

# this might be redundant, but .bashrc should be idempotent ¯\_(ツ)_/¯
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# allow for a local component
if [ -f ~/.bash_profile.mine ]; then
   source ~/.bash_profile.mine
fi
