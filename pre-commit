#!/usr/bin/env bash
# Source: https://gist.github.com/stevenharman/f5fece7fd39356e57ce3c710911f714f

set -eu

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'
CLEAR_LINE='\r\033[K'

printf "🚔    Linting with Rubocop..."

if ! command -v rubocop > /dev/null; then
  printf "${CLEAR_LINE}💀${RED}   Install Rubocop and be sure it is available on your PATH${NO_COLOR}\n"
  printf "ℹ️   Try 'gem install rubocop'\n"
  exit -1
fi

suspects="$(comm -12 <(git diff --cached --name-only --diff-filter=AMC | sort) <(rubocop --list-target-files | sort) | tr '\n' ' ')"

if [ -n "$suspects" ]; then
  if [[ ! -f .rubocop.yml ]]; then
    printf "${CLEAR_LINE}${YELLOW}⚠️   No .rubocop.yml config file.${NO_COLOR}\n"
  fi

  printf "${CLEAR_LINE}🚔   Linting files: ${suspects}"

  # Run rubocop on the staged files
  if ! rubocop --parallel --format simple ${suspects} > /dev/null
  then
    printf "${CLEAR_LINE}${RED}💀   Rubocop found some issues. Fix, stage, and commit again${NO_COLOR}\n"
    printf "ℹ️   Try 'bin/rubocop --display-cop-names --extra-details --auto-correct && git add -p'\n"
    exit -1
  fi
fi

printf "${CLEAR_LINE}🎉${GREEN}   Rubocop is happy.${NO_COLOR}\n"

printf "🕵️    RSpec Testing..."

FAILS=`bundle exec rspec --format progress | grep -E '\d failure(s?)' -o | awk '{print $1}'`
ERRORS=`bundle exec rspec --format progress | grep -E '\d error(s?)' -o | awk '{print $1}'`

if [ ! -z "$FAILS" ] && [ $FAILS -ne 0 ]; then
    echo -e "${CLEAR_LINE}${RED}✋   Can't commit! You've broken $FAILS tests!"
    exit 1
elif [ ! -z "$ERRORS" ] && [ $ERRORS -ne 0 ]; then
    echo -e "${CLEAR_LINE}${RED}✋   Can't commit! You've broken $ERRORS tests!"
    exit 1
else
    printf "${CLEAR_LINE}👍${GREEN}   Commit approved.${NO_COLOR}\n"
    exit 0
fi
