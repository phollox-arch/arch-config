#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colored output for ls command
alias ls='ls --color=auto'
alias JabRef='jabref > /dev/null 2>&1 &'
alias CV='cd ~/DATA/Dropbox/CV'
# mpc play/pause
alias mppause='mpc toggle'
# mpc status with album name
alias mpstatus='mpc -f "[[[%artist% - |%albumartist% - ][%album% - ][%title%]]|%file%]"'
alias google='w3m www.google.com'
#function mpstatus () 
#{
#mpc -f "[[[%artist% - |%albumartist% - ][%album% - ][%title%]]|%file%]"
#}
####
#dim LCD backlight using xrandr
function dimlcd ()
{
	local brightness=${1:-"1"}
	local gamma=${2:-"1.0"}
	xrandr --output LVDS1 --brightness $brightness --gamma $gamma:$gamma:$gamma
}

#Command prompt
#PS1='[\u@\h \W]\$ '
export PS1="\[\033[0;34m\](\A) \[\033[1;31m\]\u\[\033[1;35m\]@\h\[\033[1;32m\] \w:\n$\[\033[1;37m\] "

#color highligh in less
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Not working properly
#function batchResize()
#{
#  local files=${1:-"*.[Jj][Pp][Gg]"}
#  local factor=${2:-"50%"}
#  local prefix=${3:-"resized"}
#  for i in $( ls $files); do convert -resize $factor $i $prefix_$i; done
#}

function pdfsearch()
{
  find . -iname '*.pdf' | while read filename
  do
    #echo -e "\033[34;1m// === PDF Document:\033[33;1m $filename\033[0m"
    pdftotext -q -enc ASCII7 "$filename" "$filename."; grep -s -H --color=always -i $1 "$filename."
    rm -f "$filename."
  done
}

# Improve font rendering for Java applications--full antialiasing (jabref, briss)
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

function pdfcompress()
{
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$2" "$1"
}

function pdfprotect()
{
  local input=$1
  local output=$2
  local pwd=$3
  qpdf --encrypt '' "$pwd" 128 --print=none --modify=none --extract=n --accesibility=n -- "$input" "$output"
}

function searchIMG()
{
	local start=${1:-"0"}
	local end=${2:-"100"}
	for i in $(eval echo {$start..$end})
	do
		seq=`printf "%04d" $i`
		if [ ! -f "IMG_${seq}.JPG" ]
		then
			printf "IMG_%04d.JPG is missing\n" $i
			#echo "IMG_${i}.JPG is missing"
		fi
	done
}
