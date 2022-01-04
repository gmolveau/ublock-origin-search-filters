#!/bin/sh
: > combined.txt # reset combined.txt

DUCKDUCKGO_PREFIX='duckduckgo.*##[data-domain*="'
DUCKDUCKGO_SUFFIX='"]'

GOOGLE_PREFIX='google.*##.g:has(a[href*="'
GOOGLE_SUFFIX='"])'

UBLOCK_PREFIX='*://'
UBLOCK_SUFFIX='/*'

# awk formula to use only lines that DONT begin with `#` (for comments) and add prefix + suffix
awk -v prefix=$UBLOCK_PREFIX -v suffix=$UBLOCK_SUFFIX '/^[^#]/ { print prefix$0suffix }' urls.txt >> combined.txt
awk -v prefix=$DUCKDUCKGO_PREFIX -v suffix=$DUCKDUCKGO_SUFFIX '/^[^#]/ { print prefix$0suffix }' urls.txt >> combined.txt
awk -v prefix=$GOOGLE_PREFIX -v suffix=$GOOGLE_SUFFIX '/^[^#]/ { print prefix$0suffix }' urls.txt >> combined.txt

# while read -r line; do
#     echo "${prefix}${line}${suffix}"
# done < urls.txt > combined.txt