#!/bin/bash

LOG_DIR="/mnt/c/xxx-xx/error_log"
OUTPUT_FILE="log.txt"
TMP_FILE="tmp_all_matches.txt"
KEYWORDS="xp_cmdshell|EXEC|sp_configure|RECONFIGURE|Login failed|Login succeeded"
echo "Scanning logs in $LOG_DIR for suspicious SQL Server activity..."
> "$TMP_FILE"

for log in "$LOG_DIR"/ERRORLOG*; do
    echo "Scanning $log ..."
    # Convert encoding (as init utf-16)
    iconv -f UTF-16 -t UTF-8 "$log" | grep -iE "$KEYWORDS" >> "$TMP_FILE"
done

# Assuming timestamp format at line start: e.g. "2025-07-22 09:53:05 ..."
sort "$TMP_FILE" > "$OUTPUT_FILE"
echo "Scan complete. Results saved to $OUTPUT_FILE"
rm "$TMP_FILE"
