
# --- Accept command-line arguments ---
LOGFILE=$1                  # First argument: path to log file
KEYWORD=${2:-"error"}       # Second argument: keyword (default: "error")

# --- Counter variable to track matches ---
COUNT=0

echo "============================================================"
echo "         LOG FILE ANALYZER                                 "
echo "============================================================"
echo ""

# --- Validate: check if a log file path was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  [!] Usage: $0 <logfile> [keyword]"
    echo "      Example: $0 /var/log/syslog python"
    echo "      Defaulting to /var/log/syslog with keyword: '$KEYWORD'"
    echo ""
    # Try common log locations as fallback
    if [ -f "/var/log/syslog" ]; then
        LOGFILE="/var/log/syslog"
    elif [ -f "/var/log/messages" ]; then
        LOGFILE="/var/log/messages"
    else
        echo "  [✘] No log file found. Please provide a path."
        exit 1
    fi
fi

# --- do-while style retry: check if file exists and is non-empty ---
ATTEMPT=0
MAX_ATTEMPTS=3

while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    if [ ! -f "$LOGFILE" ]; then
        echo "  [✘] Attempt $((ATTEMPT+1)): File '$LOGFILE' not found."
        # Suggest an alternative on each retry
        if [ $ATTEMPT -eq 0 ] && [ -f "/var/log/syslog" ]; then
            echo "  [→] Retrying with /var/log/syslog ..."
            LOGFILE="/var/log/syslog"
        elif [ $ATTEMPT -eq 1 ] && [ -f "/var/log/messages" ]; then
            echo "  [→] Retrying with /var/log/messages ..."
            LOGFILE="/var/log/messages"
        else
            echo "  [✘] Could not find a valid log file after $MAX_ATTEMPTS attempts."
            exit 1
        fi
    elif [ ! -s "$LOGFILE" ]; then
        # File exists but is empty — do-while style retry
        echo "  [!] Attempt $((ATTEMPT+1)): File '$LOGFILE' is empty."
        echo "  [→] Waiting 2 seconds before retry..."
        sleep 2
    else
        # File found and non-empty — break out of retry loop
        echo "  [✔] Log file found: $LOGFILE"
        break
    fi
    ATTEMPT=$((ATTEMPT + 1))
done

# --- Final check before processing ---
if [ ! -f "$LOGFILE" ] || [ ! -s "$LOGFILE" ]; then
    echo "  [✘] Could not read a valid non-empty log file. Exiting."
    exit 1
fi

echo "  [✔] Keyword   : '$KEYWORD'"
echo "  [✔] Scanning  : $LOGFILE"
echo ""
echo "------------------------------------------------------------"
echo "  SCANNING LOG FILE..."
echo "------------------------------------------------------------"

# --- Temporary file to store matching lines ---
TMPFILE=$(mktemp)

# --- while-read loop: read log file line by line ---
while IFS= read -r LINE; do
    # --- if-then: check if the current line contains the keyword ---
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))       # Increment match counter
        echo "$LINE" >> "$TMPFILE" # Save matching line to temp file
    fi
done < "$LOGFILE"

# --- Display results summary ---
echo ""
echo "------------------------------------------------------------"
echo "  RESULTS SUMMARY"
echo "------------------------------------------------------------"
echo "  Keyword    : '$KEYWORD'"
echo "  Log File   : $LOGFILE"
echo "  Total Lines: $(wc -l < "$LOGFILE")"
echo "  Matches    : $COUNT"
echo ""

# --- Show last 5 matching lines if any matches exist ---
if [ $COUNT -gt 0 ]; then
    echo "------------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES"
    echo "------------------------------------------------------------"
    echo ""
    # Use tail to get last 5 entries from the temp file
    tail -5 "$TMPFILE" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
    echo ""
else
    echo "  No lines matched keyword '$KEYWORD' in $LOGFILE"
fi

# --- Clean up temporary file ---
rm -f "$TMPFILE"

echo "============================================================"
echo "  Analysis complete."
echo "============================================================"
