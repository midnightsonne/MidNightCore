#!/usr/bin/env bash

CNC='\e[0m'    # Color - Normal
CWE='\e[0;1m'  # Color - White
CBK='\e[0;30m' # Color - Black

CGY='\e[1;30m'  # Color - Light Gray
CRD='\e[0;31m'  # Color - Bold Red
CLRD='\e[1;31m' # Color - Light Red
CGN='\e[0;32m'  # Color - Bold Green
CLGN='\e[1;32m' # Color - Light Green
CYW='\e[0;33m'  # Color - Bold Yellow
CLYW='\e[1;33m' # Color - Light Yellow
CBE='\e[0;34m'  # Color - Bold Blue
CLBE='\e[1;34m' # Color - Light Blue
CPE='\e[0;35m'  # Color - Bold Purple
CLPE='\e[1;35m' # Color - Light Purple
CCN='\e[0;36m'  # Color - Bold Cyan
CLCN='\e[1;36m' # Color - Light Cyan
CLGY='\e[0;37m' # Color - Bold Gray

CBCK='\e[1;2;35m' # Back Text

TNL='\e[0;0m' # Text Format - Normal
TBD='\e[1;1m' # Text Format - Bold
TDM='\e[2;1m' # Text Format - Dim
TUD='\e[4;1m' # Text Format - Underlined
TBG='\e[5;1m' # Text Format - Blinking
TRD='\e[7;1m' # Text Format - Reversed
THN='\e[8;1m' # Text Format - Hidden

CLR_SEPARATORS=(
  "${CLRD}[ ${CNC}" # 0
  "${CLRD} ]${CNC}" # 1
  "${CRD}-${CNC}"   # 2

  "${CLGN}[ ${CNC}" # 3
  "${CLGN} ]${CNC}" # 4
  "${CGN}-${CNC}"   # 5

  "${CLBE}[ ${CNC}" # 6
  "${CLBE} ]${CNC}" # 7
  "${CBE}-${CNC}"   # 8

  "${CBCK}[ ${CNC}" # 9
  "${CBCK} ]${CNC}" # 10
  "${CBCK}-${CNC}"  # 11

  "${CRD}|${CNC}" # 12
  "${CGN}|${CNC}" # 13
  "${CBE}|${CNC}" # 14

  "${CRD}=${CNC}" # 15
  "${CGN}=${CNC}" # 16
  "${CBE}=${CNC}" # 17

  "${CRD}/${CNC}" # 18
  "${CGN}/${CNC}" # 19
  "${CBE}/${CNC}" # 20

  "${CRD}:${CNC}" # 21
  "${CGN}:${CNC}" # 22
  "${CBE}:${CNC}" # 23
)

CAMRK="\e[34m\xe2\x9c\xb1" # Check Mark - Attention
CGMRK="\e[32m\xe2\x9c\x94" # Check Mark - Good
CBMRK="\e[31m\xe2\x9c\x98" # Check Mark - Bad

USERNAME=$(awk -F '[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)

CLCASE="abcdefghijklmnopqrstuvwxyz" # Charset - Lowercase
CUCASE="ABCDEFGHIJKLMNOPQRSTUVWXYZ" # Charset - Uppercase
CNMBER="0123456789"                 # Charset - Numbers
CSYMBL="!#$%/=?{}[]-*:;"            # Charset - Symbols
