#!/usr/bin/env bash

# PLUGIN DESCRIPTION = PRINT A PROGRESS BAR
# HOW TO USE = CALL "progress_bar $1 $2 $3 $4 $5 $6 $7" WHEREVER YOU WANT IN YOUR SCRIPT

[ -z "${PROG_BARSIZE}" ] && PROG_BARSIZE="20" # PROGRESS BAR SIZE

# CALCULATE THE PROGRESS BAR
function calc_progress_bar() {
  debug_print 2>/dev/null

  PROG=$(((((CURRENT * 100) / FINISH) * 100) / 100))
  DONE=$(((PROG * (PROG_BARSIZE / 10)) / 10))
  LEFT=$((PROG_BARSIZE - DONE))

  FILL=$(printf "%${DONE}s")
  EMPTY=$(printf "%${LEFT}s")
}

# PRINT A PROGRESS BAR
function progress_bar() {
  debug_print 2>/dev/null
  case "${3}" in
    "")
      CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
      echo -en "${CLBE}" "\n ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
      ;;
    -[tT][iI][mM][eE][rR] | -[tT])
      case "${5}" in
        -[cC][lL][eE][aA][rR] | -[cC])
          case "${6}" in
            -[lL][aA][sS][tT] | -[lL])
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${4}"
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\n ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${4}"
              ;;
          esac
          ;;
        -[lL][aA][sS][tT] | -[lL])
          case "${6}" in
            -[cC][lL][eE][aA][rR] | -[cC])
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${4}"
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${4}"
              ;;
          esac
          ;;
        *)
          CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
          echo -en "${CLBE}" "\n ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${4}"
          ;;
      esac
      ;;
    -[cC][lL][eE][aA][rR] | -[cC])
      case "${4}" in
        -[tT][iI][mM][eE][rR] | -[tT])
          case "${6}" in
            -[lL][aA][sS][tT] | -[lL])
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\n ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
              ;;
          esac
          ;;
        -[lL][aA][sS][tT] | -[lL])
          case "${5}" in
            -[tT][iI][mM][eE][rR] | -[tT])
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${6}"
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
              ;;
          esac
          ;;
        *)
          CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
          echo -en "${CLBE}" "\n ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
          ;;
      esac
      ;;
    -[lL][aA][sS][tT] | -[lL])
      case "${4}" in
        -[tT][iI][mM][eE][rR] | -[tT])
          case "${6}" in
            -[cC][lL][eE][aA][rR] | -[cC])
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
              ;;
          esac
          ;;
        -[cC][lL][eE][aA][rR] | -[cC])
          case "${5}" in
            -[tT][iI][mM][eE][rR] | -[tT])
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${6}"
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
              ;;
          esac
          ;;
        *)
          CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
          echo -en "${CLBE}" "\r ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
          ;;
      esac
      ;;
    *)
      case "${4}" in
        -[tT][iI][mM][eE][rR] | -[tT])
          case "${6}" in
            -[cC][lL][eE][aA][rR] | -[cC])
              case "${7}" in
                -[lL][aA][sS][tT] | -[lL])
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
                  ;;
                *)
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\n ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
                  ;;
              esac
              ;;
            -[lL][aA][sS][tT] | -[lL])
              case "${7}" in
                -[cC][lL][eE][aA][rR] | -[cC])
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
                  ;;
                *)
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
                  ;;
              esac
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
              echo -en "${CLBE}" "\n ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${5}"
              ;;
          esac
          ;;
        -[cC][lL][eE][aA][rR] | -[cC])
          case "${5}" in
            -[tT][iI][mM][eE][rR] | -[tT])
              case "${7}" in
                -[lL][aA][sS][tT] | -[lL])
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${6}"
                  ;;
                *)
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\n ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${6}"
                  ;;
              esac
              ;;
            -[lL][aA][sS][tT] | -[lL])
              case "${6}" in
                -[tT][iI][mM][eE][rR] | -[tT])
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${7}"
                  ;;
                *)
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
                  ;;
              esac
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
              echo -en "${CLBE}" "\n ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
              ;;
          esac
          ;;
        -[lL][aA][sS][tT] | -[lL])
          case "${5}" in
            -[tT][iI][mM][eE][rR] | -[tT])
              case "${7}" in
                -[cC][lL][eE][aA][rR] | -[cC])
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${6}"
                  ;;
                *)
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${6}"
                  ;;
              esac
              ;;
            -[cC][lL][eE][aA][rR] | -[cC])
              case "${6}" in
                -[tT][iI][mM][eE][rR] | -[tT])
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% " && sleep "${7}"
                  ;;
                *)
                  CURRENT="${1}" && FINISH="${2}" && calc_progress_bar && clear
                  echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
                  ;;
              esac
              ;;
            *)
              CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
              echo -en "${CLBE}" "\r ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
              ;;
          esac
          ;;
        *)
          CURRENT="${1}" && FINISH="${2}" && calc_progress_bar
          echo -en "${CLBE}" "\n ${3} : ${CNC}[${FILL// /#}${EMPTY// /-}] ${PROG}% "
          ;;
      esac
      ;;
  esac
}
