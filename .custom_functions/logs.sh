# Search log files
function slog {
    cd ~/cernbox/dphil/logs
    grep -H $1 201*/*/*
    cd - > /dev/null
}

# Open log file for a specific date
function hlog {
    # Check for number of variables
    if [[ $# -gt 1 ]]; then
        DAY=$1
        MONTH=$2
        if [[ $# -gt 2 ]]; then
            YEAR=$3
        else
            YEAR=2017
        fi
        TODAY=0
    elif [[ $# -eq 0 ]]; then
        DAY=$(date +%d)
        MONTH=$(date +%m)
        YEAR=$(date +%y)
        TODAY=1
    else 
        if [[ $1 =~ (y|yday|yesterday|Yesterday) ]]; then
            DAY_DIFF=1
        else 
            if [[ $1 =~ (mon|Mon|m|M|monday|Monday) ]]; then
                DAY_NUM=1
            elif [[ $1 =~ (tue|Tues|tu|Tu|tues|Tues|tuesday|Tuesday) ]]; then
                DAY_NUM=2
            elif [[ $1 =~ (wed|Wed|w|W|weds|Weds|wednesday|Wednesday) ]]; then
                DAY_NUM=3
            elif [[ $1 =~ (thu|Thu|th|Th|thurs|Thurs|thursday|Thursday) ]]; then
                DAY_NUM=4
            elif [[ $1 =~ (fri|Fri|f|F|friday|Friday) ]]; then
                DAY_NUM=5
            elif [[ $1 =~ (sat|Sat|sa|Sa|saturday|Saturday) ]]; then
                DAY_NUM=6
            elif [[ $1 =~ (sun|Sun|su|Su|sunday|Sunday) ]]; then
                DAY_NUM=7
            else 
                echo "Day not recognised."
                return -1
            fi
            CURRENT_DAY=$(date +%u)
            if [[ $DAY_NUM -ge $CURRENT_DAY ]]; then
                CURRENT_DAY=$(( $CURRENT_DAY + 7 ))
            fi
            DAY_DIFF=$(( $CURRENT_DAY - $DAY_NUM ))
        fi
        DAY=$(date -v-${DAY_DIFF}d +%d)
        MONTH=$(date -v-${DAY_DIFF}d +%m)
        YEAR=$(date -v-${DAY_DIFF}d +%y)
        TODAY=0
    fi


    # Format day
    if [[ ${#DAY} -lt 2 ]]; then
        DAY="0"$DAY
    elif [[ $DAY -gt 31 ]]; then
        echo "Please specify a valid date!"
        return -1
    fi

    # Format month
    if [[ $MONTH =~ ^[0-9]+$ ]]; then
        if [[ $MONTH -gt 12 ]]; then
            echo "Please specify a valid month!"
            return -1
        elif [[ ${#MONTH} -eq 1 ]]; then
            MONTH="0"$MONTH
        fi
    else
        if [[ $MONTH =~ ^(jan|Jan|january|January)$ ]]; then
            MONTH=01
        elif [[ $MONTH =~ ^(feb|Feb|february|February)$ ]]; then
            MONTH=02
        elif [[ $MONTH =~ ^(mar|Mar|march|March)$ ]]; then
            MONTH=03
        elif [[ $MONTH =~ ^(apr|Apr|april|April)$ ]]; then
            MONTH=04
        elif [[ $MONTH =~ ^(may|May)$ ]]; then
            MONTH=05
        elif [[ $MONTH =~ ^(jun|Jun|june|June)$ ]]; then
            MONTH=06
        elif [[ $MONTH =~ ^(jul|Jul|july|July)$ ]]; then
            MONTH=07
        elif [[ $MONTH =~ ^(aug|Aug|august|August)$ ]]; then
            MONTH=08
        elif [[ $MONTH =~ ^(sep|Sep|sept|Sept|september|September)$ ]]; then
            MONTH=09
        elif [[ $MONTH =~ ^(oct|Oct|october|October)$ ]]; then
            MONTH=10
        elif [[ $MONTH =~ ^(nov|Nov|november|November)$ ]]; then
            MONTH=11
        elif [[ $MONTH =~ ^(dec|Dec|december|December)$ ]]; then
            MONTH=12
        fi
    fi
    set -A monthnames January February March April May June July August September October November December
    MONTHNAME=${monthnames[${MONTH}]}

    # Format year
    if [[ ${#YEAR} -eq 2 ]]; then
        YEAR="20"$YEAR
    elif [ ${#YEAR} -ne 4 ]; then
        echo "Please specify a valid year!"
        return -1
    fi

    # Open the correct log
    if [[ ! -d ~/cernbox/dphil/logs/$YEAR ]]; then
        if [[ $TODAY -eq 0 ]]; then
            echo "No records found for $YEAR. Create a record?"
            read RESPONSE
            if [[ ! $RESPONSE =~ (y|Y|yes|Yes|YES) ]]; then
                return -1
            fi
        fi
        mkdir ~/cernbox/dphil/logs/$YEAR
        mkdir ~/cernbox/dphil/logs/$YEAR/$MONTHNAME
    elif [[ ! -d ~/cernbox/dphil/logs/$YEAR/$MONTHNAME ]]; then
        if [[ $TODAY -eq 0 ]]; then
            echo "No records found for $MONTHNAME $YEAR. Create a record?"
            read RESPONSE
            if [[ ! $RESPONSE =~ (y|Y|yes|Yes|YES) ]]; then
                return -1
            fi
        fi
        mkdir ~/cernbox/dphil/logs/$YEAR/$MONTHNAME
    elif [[ ! -e ~/cernbox/dphil/logs/$YEAR/$MONTHNAME/$DAY.txt ]]; then
        if [[ $TODAY -eq 0 ]]; then
            echo "No records found for $DAY $MONTHNAME $YEAR. Create a record?"
            read RESPONSE
            if [[ ! $RESPONSE =~ (y|Y|yes|Yes|YES) ]]; then
                return -1
            fi
        fi
    fi
    vim ~/cernbox/dphil/logs/$YEAR/$MONTHNAME/$DAY.txt
}

function clog {
    DAY1=$(date +%d)
    MONTH1=$(date +%m)
    YEAR1=$(date +%y)
    DAY2=$(date -v-1d +%d)
    MONTH2=$(date -v-1d +%m)
    YEAR2=$(date -v-1d +%y)

    # Format days
    if [[ ${#DAY1} -lt 2 ]]; then
        DAY1="0"$DAY1
    elif [[ $DAY1 -gt 31 ]]; then
        echo "Please specify a valid date!"
        return -1
    fi
    if [[ ${#DAY2} -lt 2 ]]; then
        DAY2="0"$DAY2
    elif [[ $DAY2 -gt 31 ]]; then
        echo "Please specify a valid date!"
        return -1
    fi

    # Format month
    if [[ $MONTH1 =~ ^[0-9]+$ ]]; then
        if [[ $MONTH1 -gt 12 ]]; then
            echo "Please specify a valid month!"
            return -1
        elif [[ ${#MONTH1} -eq 1 ]]; then
            MONTH1="0"$MONTH1
        fi
    else
        if [[ $MONTH1 =~ ^(jan|Jan|january|January)$ ]]; then
            MONTH1=01
        elif [[ $MONTH1 =~ ^(feb|Feb|february|February)$ ]]; then
            MONTH1=02
        elif [[ $MONTH1 =~ ^(mar|Mar|march|March)$ ]]; then
            MONTH1=03
        elif [[ $MONTH1 =~ ^(apr|Apr|april|April)$ ]]; then
            MONTH1=04
        elif [[ $MONTH1 =~ ^(may|May)$ ]]; then
            MONTH1=05
        elif [[ $MONTH1 =~ ^(jun|Jun|june|June)$ ]]; then
            MONTH1=06
        elif [[ $MONTH1 =~ ^(jul|Jul|july|July)$ ]]; then
            MONTH1=07
        elif [[ $MONTH1 =~ ^(aug|Aug|august|August)$ ]]; then
            MONTH1=08
        elif [[ $MONTH1 =~ ^(sep|Sep|sept|Sept|september|September)$ ]]; then
            MONTH1=09
        elif [[ $MONTH1 =~ ^(oct|Oct|october|October)$ ]]; then
            MONTH1=10
        elif [[ $MONTH1 =~ ^(nov|Nov|november|November)$ ]]; then
            MONTH1=11
        elif [[ $MONTH1 =~ ^(dec|Dec|december|December)$ ]]; then
            MONTH1=12
        fi
    fi
    if [[ $MONTH2 =~ ^[0-9]+$ ]]; then
        if [[ $MONTH2 -gt 12 ]]; then
            echo "Please specify a valid month!"
            return -1
        elif [[ ${#MONTH2} -eq 1 ]]; then
            MONTH2="0"$MONTH2
        fi
    else
        if [[ $MONTH2 =~ ^(jan|Jan|january|January)$ ]]; then
            MONTH2=01
        elif [[ $MONTH2 =~ ^(feb|Feb|february|February)$ ]]; then
            MONTH2=02
        elif [[ $MONTH2 =~ ^(mar|Mar|march|March)$ ]]; then
            MONTH2=03
        elif [[ $MONTH2 =~ ^(apr|Apr|april|April)$ ]]; then
            MONTH2=04
        elif [[ $MONTH2 =~ ^(may|May)$ ]]; then
            MONTH2=05
        elif [[ $MONTH2 =~ ^(jun|Jun|june|June)$ ]]; then
            MONTH2=06
        elif [[ $MONTH2 =~ ^(jul|Jul|july|July)$ ]]; then
            MONTH2=07
        elif [[ $MONTH2 =~ ^(aug|Aug|august|August)$ ]]; then
            MONTH2=08
        elif [[ $MONTH2 =~ ^(sep|Sep|sept|Sept|september|September)$ ]]; then
            MONTH2=09
        elif [[ $MONTH2 =~ ^(oct|Oct|october|October)$ ]]; then
            MONTH2=10
        elif [[ $MONTH2 =~ ^(nov|Nov|november|November)$ ]]; then
            MONTH2=11
        elif [[ $MONTH2 =~ ^(dec|Dec|december|December)$ ]]; then
            MONTH2=12
        fi
    fi
    set -A monthnames January February March April May June July August September October November December
    MONTH1NAME=${monthnames[${MONTH1}]}
    MONTH2NAME=${monthnames[${MONTH2}]}

    # Format year
    if [[ ${#YEAR1} -eq 2 ]]; then
        YEAR1="20"$YEAR1
    elif [ ${#YEAR1} -ne 4 ]; then
        echo "Please specify a valid year!"
        return -1
    fi
    if [[ ${#YEAR2} -eq 2 ]]; then
        YEAR2="20"$YEAR2
    elif [ ${#YEAR2} -ne 4 ]; then
        echo "Please specify a valid year!"
        return -1
    fi

    vim -O ~/cernbox/dphil/logs/$YEAR2/$MONTH2NAME/$DAY2.txt ~/cernbox/dphil/logs/$YEAR1/$MONTH1NAME/$DAY1.txt 



}
