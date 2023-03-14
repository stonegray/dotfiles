
alias j="autojump"

# Sorry, ghostscript
alias gs="git status"


# Espressif IDF
if [ -f ~/esp/esp-idf/export.sh ]; then
	alias get_idf='. $HOME/esp/esp-idf/export.sh'
else
	echo "E: did not detect esp-idf"
fi


