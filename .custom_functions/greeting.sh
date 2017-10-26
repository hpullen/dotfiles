HOUR=`date +%H`
if [[ $HOUR -lt 6 ]]; then
    figlet "It's a bit late..." | lolcat
elif [[ $HOUR -lt 12 ]]; then
    figlet "Good morning!" | lolcat 
elif [[ $HOUR -lt 18 ]]; then
    figlet "Good afternoon!" | lolcat
else 
    figlet "Good evening!" | lolcat
fi
