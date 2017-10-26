# Restore deleted files from trash
function restore { 
    FILENAME="$1"
    TRASHPATH="~/.Trash/$FILENAME"
    mv "$TRASHPATH" .
}
