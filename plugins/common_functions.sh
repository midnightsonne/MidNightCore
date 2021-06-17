#!/usr/bin/env bash

# CONTINUE COLLECTION
function funcContinue() {
  debug_print 2>/dev/null
  case "${1}" in
    1)
      echo -en "${CLBE}" " PRESS ${CNC}[ENTER]${CLBE} TO CONTINUE ... " "${CNC}"
      ;;
    2)
      echo -en "${CLBE}" " CONTINUE ? ${CNC}(Y/N)${CLBE} > " "${CNC}"
      ;;
    3)
      echo -en "${CLBE}" " CONTINUE ? ${CNC}(Y/n)${CLBE} > " "${CNC}"
      ;;
    4)
      echo -en "${CLBE}" " CONTINUE ? ${CNC}(y/N)${CLBE} > " "${CNC}"
      ;;
    5)
      echo -en "${CLBE}" " CONTINUE ? ${CNC}(y/n)${CLBE} > " "${CNC}"
      ;;
    6)
      echo -en "${CLBE}" " THIS OPTION IS NOT ENABLED YET " "${CNC}"
      ;;
  esac && read -r continue
}

# COMPARE COLLECTION
function funcCompare() {
  debug_print 2>/dev/null
  case "${1}" in
    1) # n1 IS GREATER THEN n2
      awk -v n1="${2}" -v n2="${3}" 'BEGIN{if (n1 > n2) exit 0; exit 1}'
      ;;
    2) # n1 IS GREATER OR SAME AS n2
      awk -v n1="${2}" -v n2="${3}" 'BEGIN{if (n1 >= n2) exit 0; exit 1}'
      ;;
    3) # n1 IS LESS THEN n2
      awk -v n1="${2}" -v n2="${3}" 'BEGIN{if (n1 < n2) exit 0; exit 1}'
      ;;
    4) # n1 IS LESS OR SAME AS n2
      awk -v n1="${2}" -v n2="${3}" 'BEGIN{if (n1 <= n2) exit 0; exit 1}'
      ;;
    5) # n1 IS THE SAME AS n2
      awk -v n1="${2}" -v n2="${3}" 'BEGIN{if (n1 = n2) exit 0; exit 1}'
      ;;
    6) # n1 IS NOT THE SAME AS n2
      awk -v n1="${2}" -v n2="${3}" 'BEGIN{if (n1 != n2) exit 0; exit 1}'
      ;;
  esac
}
