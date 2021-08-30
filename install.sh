white="\033[1;37m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
purple="\033[0;35m"
cyan="\033[0;36m"
blue="\033[1;34m"
clear
echo -e "
${blue} ____       _   _____           _
${green}/ ___|  ___| |_|  ___|__  _ __ | |_
${red}\___ \ / _ \ __| |_ / _ \| '_ \| __|
${blue} ___) |  __/ |_|  _| (_) | | | | |_
${yellow}|____/ \___|\__|_|  \___/|_| |_|\__|
${purple}                      [By KasRoudra]
"
sleep 2
chmod +x *
echo -e "${cyan}[+] ${green}Installing files.......\n"
sleep 3
cp -r setfont.sh $PREFIX/etc
cp -r setfont $PREFIX/bin
echo -e "${cyan}[+] ${yellow}SetFont successfully installed.\n"
echo -e "${cyan}[+] ${green}Run ${purple}'setfont'${green} from anywhere and enjoy!\n"
termux-reload-settings
