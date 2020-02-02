#
# ~/.bash_profile
#

# TeX Live environment variables
export PATH=/usr/local/texlive/2018/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2018/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2018/texmf-dist/doc/info:$INFOPATH

export DESKTOP_SESSION=LXDE

# EDITOR
export EDITOR=vim

# Export PATH to add scripts Tools
export PATH=$HOME/scriptTools:$PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start LXDE after prompting
if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
  while true; do
    read -p 'Do you want to start the graphical interface? (y/n): '
    case $REPLY in
      #[Yy]) exec xinit -- /usr/bin/X -nolisten tcp vt7 ;;
      [Yy]) startx ;;
      [Nn]) break ;;
      *) printf '%s\n' 'Please answer y or n.' ;;
    esac
  done
fi
