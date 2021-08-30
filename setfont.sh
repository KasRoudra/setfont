#!/data/data/com.termux/files/usr/bin/bash

# SetFont
# Author     : KasRoudra
# Github     : https://github.com/KasRoudra
# Email      : kasroudrakrd@gmail.com
# Contact    : https://m.me/KasRoudra
# Description: Change font of termux. Apply font of any directory


white="\033[1;37m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
purple="\033[0;35m"
cyan="\033[0;36m"
blue="\033[1;34m"

info="${cyan}[${white}+${cyan}] ${yellow}"
ask="${cyan}[${white}?${cyan}] ${purple}"
error="${cyan}[${white}!${cyan}] ${red}"
success="${cyan}[${white}√${cyan}] ${green}"

re='^[0-9]+$'

if ! [ -d "$HOME/setfont/fonts" ]
then
cd $HOME
mkdir setfont
cd setfont
mkdir fonts
fi
export DIR="$HOME/setfont/fonts"
clear
echo -e "
${blue} ____       _   _____           _
${green}/ ___|  ___| |_|  ___|__  _ __ | |_
${red}\___ \ / _ \ __| |_ / _ \| '_ \| __|
${blue} ___) |  __/ |_|  _| (_) | | | | |_
${yellow}|____/ \___|\__|_|  \___/|_| |_|\__|
${purple}                      [By KasRoudra]
"
if [ -f font.ttf ]; then
rm -rf font.ttf
fi
loop=true
while $loop; do
	trap '' 2
	printf "\n${yellow}SetFont > ${purple}"
	read cmd
	if [ "$cmd" = "help" ]; then
		echo -e "\n${info}${cyan}List of commands:${yellow}
${purple}> help           ${yellow}Shows this help
${purple}> list           ${yellow}Shows fontlist
${purple}> chdir${green} <path>${yellow}   Changes fontlist directory (current: $blue$DIR$yellow)
${purple}> apply${green} <number>${yellow} Applies that font
${purple}> backup         ${yellow}Backup the current font ${cyan}(Recommended before random change)
${purple}> restore        ${yellow}Restores the backed up font
${purple}> reset          ${yellow}Resets to a default ${blue}Fira ${yellow}font
${purple}> exit           ${yellow}Exit from this program"
	elif [ "$cmd" = "list" ]; then
	echo
		getlist=$(ls $DIR | grep ttf)
		replace=${getlist// /%%}
		n=1
		if ! [[ $replace == "" ]]; then
		    for font in $replace; do
		    if (( $n % 2 == 0 )) ; then
			    echo -e "${yellow}[$n]${blue} ${font//%%/ }"
		    else
		        echo -e "${green}[$n]${purple} ${font//%%/ }"
		    fi
		    ((n++))
		    done
		else
		    echo -e "${error}No font here!"
		fi
	elif echo "$cmd" | grep -q "apply"; then
		arg=$(echo "$cmd" | cut -d " " -f 2)
		if [[ $arg =~ $re ]] ; then
		    getlist=$(ls $DIR | grep ttf)
		    replace=${getlist// /%%}
		    list=()
		    for m in $replace; do
			    list+=("$m")
		    done
		    font=${list[(($arg-1))]}
		    if [[ ${font//%%/ } == "" ]]; then
		        echo -e "\n${error}Font not found!"
		    else
		        cp "$DIR/${font//%%/ }" "font.ttf"
		        if [ -f $HOME/.termux/font.ttf ]; then
		            rm -rf $HOME/.termux/font.ttf
		        fi
		        mv -f font.ttf $HOME/.termux
                termux-reload-settings
                echo -e "\n${success}Font applied successfully!"
            fi
        else
            echo -e "\n${error}Not a number!"
        fi    
	elif echo "$cmd" | grep -q "reset"; then
	    if [ -f "$HOME/setfont/fira.ttf" ]; then
		    cp "$HOME/setfont/fira.ttf" "font.ttf"
		    if [ -f $HOME/.termux/font.ttf ]; then
		        rm -rf $HOME/.termux/font.ttf
		    fi
		    mv -f font.ttf $HOME/.termux
            termux-reload-settings
            echo -e "\n${success}Font reset successfully!"
        else
            echo -e "\n${error}Reset font not found"!
        fi
	elif echo "$cmd" | grep -q "backup"; then
	    if [ -f "$HOME/.termux/font.ttf" ]; then
	        if [ -f "$HOME/.termux/backup.ttf" ]; then
		        rm -rf $HOME/.termux/backup.ttf
		    fi
		    cp "$HOME/.termux/font.ttf" "backup.ttf"
		    mv -f backup.ttf $HOME/.termux
            termux-reload-settings
            echo -e "\n${success}Font backed up successfully!"
        else
            echo -e "\n${error}Font to be backed up not found. Please apply one!"
        fi
	elif echo "$cmd" | grep -q "restore"; then
	    if [ -f "$HOME/.termux/backup.ttf" ]; then
	        cd $HOME/.termux
	        if [ -f $HOME/.termux/font.ttf ]; then
		        rm -rf $HOME/.termux/font.ttf
		    fi
		    mv backup.ttf font.ttf
            termux-reload-settings
            echo -e "\n${success}Font restored successfully!"
        else
            echo -e "\n${error}No backup found!"
        fi        
	elif echo "$cmd" | grep -q "chdir"; then
		path="$(echo "$cmd" | cut -d " " -f 2)"
		if [[ -d "$path" ]]; then
		    export DIR="${path}"
		    if [ -f font.ttf ]; then
		        rm -rf font.ttf
		    fi
		    echo -e "\n${success}Directory changed!"
		else
		    echo -e "\n${error}Path do not exist!"
		fi   
	elif [ "$cmd" = "exit" ]; then
		echo -e "${white}"
		exit
	else
		echo -e "\n${error}Sorry, wrong input! Please type 'help'."
	fi
done
