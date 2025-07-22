#!/bin/bash

LOG_DIR="/mnt/c/path/ok/error_log"
OUTPUT_FILE="log.txt"
KEYWORDS="xp_cmdshell|EXEC|sp_configure|RECONFIGURE|Login failed|Login succeeded"

echo "Scanning logs in $LOG_DIR for suspicious SQL Server activity..." | tee "$OUTPUT_FILE"

for log in "$LOG_DIR"/ERRORLOG*; do
    echo -e "\n--- Scanning $log ---" | tee -a "$OUTPUT_FILE"
    iconv -f UTF-16 -t UTF-8 "$log" | grep -iE -C 2 "$KEYWORDS" | tee -a "$OUTPUT_FILE"
    echo "----- End of matches in $log -----" | tee -a "$OUTPUT_FILE"
done

echo "Scan complete." | tee -a "$OUTPUT_FILE"

