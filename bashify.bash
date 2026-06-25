# BASHIFY: A Minimalist Powerlevel10k-Inspired Bash Prompt
#
# Lightweight, modular, and lightning-fast—this prompt system captures the spirit
# of Oh My Zsh's Powerlevel10k while staying true to Bash’s simplicity. Designed
# for developers who want a visually clear, Git-aware, and extensible PS1 without
# the bloat.
#
# Features:
# - Git-integrated prompt: shows branch, status, stashes, conflicts, and remotes
# - Customizable path formats: full, compact, shortened, anchored
# - Right-aligned segments: Node.js version, background jobs, Bash version, time
# - 256-color support via xterm ANSI escape sequences
# - Fully configurable and modular—easy to extend and adapt

#############################################################################
# DEFINITIONS
#############################################################################

# style reset and attributes
BASHIFY_STYLE_BLINK_OFF="\[\033[25m\]"
BASHIFY_STYLE_BLINK_ON="\[\033[5m\]"
BASHIFY_STYLE_BOLD="\[\033[1m\]"
BASHIFY_STYLE_RESET="\[\033[0m\]"

# base colors (Powerlevel10k-mapped)
BASHIFY_FG_BLUE="\[\033[38;5;31m\]"         # dir
BASHIFY_FG_CYAN="\[\033[38;5;66m\]"         # time, execution time
BASHIFY_FG_GRAY="\[\033[38;5;244m\]"        # meta
BASHIFY_FG_GREEN="\[\033[38;5;76m\]"        # clean, success
BASHIFY_FG_LIGHT_BLUE="\[\033[38;5;81m\]"   # time
BASHIFY_FG_LIGHT_GREEN="\[\033[38;5;114m\]" # optional alt green
BASHIFY_FG_MAGENTA="\[\033[0;35m\]"         # bashver
BASHIFY_FG_ORANGE="\[\033[38;5;208m\]"      # staged, modified
BASHIFY_FG_PINK="\[\033[38;5;103m\]"        # shortened dir
BASHIFY_FG_PURPLE="\[\033[38;5;39m\]"       # anchor dir
BASHIFY_FG_RED="\[\033[38;5;196m\]"         # error, conflict
BASHIFY_FG_WHITE="\[\033[0;37m\]"           # default
BASHIFY_FG_YELLOW="\[\033[38;5;220m\]"      # jobs, warnings

#############################################################################
# CONFIGURATION (override in ~/.config/bashify/bashifyrc)
#############################################################################

# right prompt settings
BASHIFY_RIGHT_PROMPT_ENABLED=true  # set to false to disable right-side segments

# user module settings
BASHIFY_USER_COLOR="$BASHIFY_FG_GREEN"

# hostname module settings
BASHIFY_HOSTNAME_COLOR="$BASHIFY_FG_GREEN"

# dir module settings
BASHIFY_DIR_MAX_LENGTH=30
BASHIFY_DIR_STYLE="compactalt"
BASHIFY_DIR_MAX_COMPONENTS=4
BASHIFY_DIR_COMPACT_MIN_LEN=3
BASHIFY_DIR_COLOR="$BASHIFY_FG_BLUE"
BASHIFY_DIR_COLOR_SHORTENED="$BASHIFY_FG_PINK"
BASHIFY_DIR_COLOR_ANCHOR="${BASHIFY_FG_BLUE}${BASHIFY_STYLE_BOLD}"
BASHIFY_DIR_ICON=""
BASHIFY_DIR_TRUNCATE_ICON="..."

# git module settings
BASHIFY_GIT_CACHE_TIMEOUT=3
BASHIFY_GIT_SHOW_DIRTY=true
BASHIFY_GIT_SHOW_AHEAD_BEHIND=true
# git colors
BASHIFY_GIT_COLOR_BRANCH="$BASHIFY_FG_GREEN"
BASHIFY_GIT_COLOR_REMOTE="$BASHIFY_FG_GREEN"
BASHIFY_GIT_COLOR_CLEAN="$BASHIFY_FG_GREEN"
BASHIFY_GIT_COLOR_AHEAD="$BASHIFY_FG_GREEN"
BASHIFY_GIT_COLOR_BEHIND="$BASHIFY_FG_GREEN"
BASHIFY_GIT_COLOR_AHEAD_BEHIND="$BASHIFY_FG_GREEN"
BASHIFY_GIT_COLOR_STAGED="$BASHIFY_FG_ORANGE"
BASHIFY_GIT_COLOR_UNSTAGED="$BASHIFY_FG_ORANGE"
BASHIFY_GIT_COLOR_UNTRACKED="$BASHIFY_FG_PURPLE"
BASHIFY_GIT_COLOR_CONFLICT="$BASHIFY_FG_RED"
BASHIFY_GIT_COLOR_UNMERGED="$BASHIFY_FG_RED"
BASHIFY_GIT_COLOR_STASH="$BASHIFY_FG_CYAN"
BASHIFY_GIT_COLOR_META="$BASHIFY_FG_GRAY"
BASHIFY_GIT_COLOR_LOADING="$BASHIFY_FG_GRAY"
# git icons
BASHIFY_GIT_ICON_BRANCH=""
BASHIFY_GIT_ICON_CHECK=""
BASHIFY_GIT_ICON_WARNING="!"
BASHIFY_GIT_ICON_REMOTE=""
BASHIFY_GIT_ICON_STASH="*"
BASHIFY_GIT_ICON_STAGED="+"
BASHIFY_GIT_ICON_UNSTAGED="~"
BASHIFY_GIT_ICON_UNTRACKED="?"
BASHIFY_GIT_ICON_CONFLICT="x"
BASHIFY_GIT_ICON_AHEAD="^"
BASHIFY_GIT_ICON_BEHIND="v"

# node module settings
BASHIFY_NODE_COLOR="$BASHIFY_FG_GREEN"
BASHIFY_NODE_ICON=""
BASHIFY_NODE_SHOW_SOURCE=false

# prompt char module settings
BASHIFY_PROMPT_CHAR_ICON=">"
BASHIFY_PROMPT_CHAR_COLOR_SUCCESS="$BASHIFY_FG_GREEN"
BASHIFY_PROMPT_CHAR_COLOR_FAILURE="$BASHIFY_FG_RED"

# status module settings
BASHIFY_STATUS_COLOR="$BASHIFY_FG_RED"
BASHIFY_STATUS_ICON="!!"

# jobs module settings
BASHIFY_JOBS_COLOR="$BASHIFY_FG_YELLOW"
BASHIFY_JOBS_ICON="&"

# bashver module settings
BASHIFY_BASHVER_COLOR="$BASHIFY_FG_MAGENTA"
BASHIFY_BASHVER_ICON="$"

# time module settings
BASHIFY_TIME_COLOR="$BASHIFY_FG_LIGHT_BLUE"

# execution time module (optional)
BASHIFY_EXEC_TIME_COLOR="$BASHIFY_FG_CYAN"
BASHIFY_EXEC_TIME_THRESHOLD=3 # seconds

# additional: optional load/cpu/memory/vpn modules (future-proofing)
BASHIFY_LOAD_COLOR_NORMAL="$BASHIFY_FG_GREEN"
BASHIFY_LOAD_COLOR_WARNING="$BASHIFY_FG_YELLOW"
BASHIFY_LOAD_COLOR_CRITICAL="$BASHIFY_FG_RED"

BASHIFY_RAM_COLOR="$BASHIFY_FG_CYAN"
BASHIFY_SWAP_COLOR="$BASHIFY_FG_MAGENTA"

BASHIFY_VPN_COLOR="$BASHIFY_FG_LIGHT_GREEN"
BASHIFY_PROXY_COLOR="$BASHIFY_FG_CYAN"
BASHIFY_PUBLIC_IP_COLOR="$BASHIFY_FG_BLUE"

# define the order of modules for left side
BASHIFY_LEFT_PROMPT_ELEMENTS=(
  # user        # show username
  # hostname    # show hostname
  dir         # show current directory
  git         # show git branch and status
  prompt_char # show prompt character
  status      # show exit code of last command when non-zero
)

# define the order of modules for right side
BASHIFY_RIGHT_PROMPT_ELEMENTS=(
  jobs    # show number of background jobs
  node    # show node.js version when in node project
  bashver # show bash version information
  time    # show current time in prompt
)

# offset added to adjust right prompt alignment; can be negative, zero, or positive
BASHIFY_RIGHT_PROMPT_OFFSET=0

# user configuration file - overrides defaults if present.
# resolution order (first match wins):
#   1. an explicit BASHIFY_USER_CONFIG set by the user
#   2. the XDG location ${XDG_CONFIG_HOME:-~/.config}/bashify/bashifyrc (preferred)
#   3. the legacy ~/.bashifyrc dotfile (kept for backward compatibility)
# when none exist, default to the XDG path so new configs land in the right place.
if [[ -z "${BASHIFY_USER_CONFIG:-}" ]]; then
  _bashify_xdg_config="${XDG_CONFIG_HOME:-$HOME/.config}/bashify/bashifyrc"
  if [[ -f "$_bashify_xdg_config" ]]; then
    BASHIFY_USER_CONFIG="$_bashify_xdg_config"
  elif [[ -f "$HOME/.bashifyrc" ]]; then
    BASHIFY_USER_CONFIG="$HOME/.bashifyrc"
  else
    BASHIFY_USER_CONFIG="$_bashify_xdg_config"
  fi
  unset _bashify_xdg_config
fi
[[ -f "$BASHIFY_USER_CONFIG" ]] && source "$BASHIFY_USER_CONFIG"

# automatically disable right prompt inside Docker containers and dumb terminals;
# can be overridden by setting BASHIFY_RIGHT_PROMPT_ENABLED=true in your bashifyrc
if [[ -f /.dockerenv || "$TERM" == "dumb" ]]; then
  BASHIFY_RIGHT_PROMPT_ENABLED=false
fi

#############################################################################
# MODULES FUNCTIONS
#############################################################################

# user module - shows username
get_user_segment() {
  printf "%s" "${BASHIFY_USER_COLOR}\u${BASHIFY_STYLE_RESET}"
}

# hostname module - shows short hostname
get_hostname_segment() {
  local hostname=$(_bashify_get_short_hostname)
  printf "%s" "${BASHIFY_HOSTNAME_COLOR}@${hostname}${BASHIFY_STYLE_RESET} "
}

# dir module - shows current directory with formatting matching original .bashrc
get_dir_segment() {
  local path_style="${BASHIFY_DIR_STYLE:-name}"
  local dir=""

  # default configuration parameters
  local max_length="${BASHIFY_DIR_MAX_LENGTH:-30}"
  local max_components="${BASHIFY_DIR_MAX_COMPONENTS:-4}"

  # inner function for full dir style
  _get_dir_path() {
    # echo "${PWD/#$HOME/\~}"
    local dir="${PWD/#$HOME/\~}"
    # FIX: root "/" splits into a single empty element that falls into the anchor
    # branch as an empty segment, collapsing the display to nothing. Render it as
    # a literal anchored "/".
    if [[ "$dir" == "/" ]]; then
      printf "%s" "${BASHIFY_DIR_COLOR_ANCHOR}/${BASHIFY_STYLE_RESET}"
      return
    fi
    local parts=()
    IFS='/' read -ra parts <<<"$dir"
    local last_index=$((${#parts[@]} - 1))
    local dir_parts=()
    for i in "${!parts[@]}"; do
      local segment="${parts[i]}"
      if [[ "$segment" == "~" ]]; then
        dir_parts+=("~")
      elif ((i == last_index)); then
        dir_parts+=("${BASHIFY_DIR_COLOR_ANCHOR}${segment}${BASHIFY_STYLE_RESET}")
      elif [[ -n "$segment" ]]; then
        dir_parts+=("${segment}")
      fi
    done
    local IFS=/
    printf "%s" "${dir_parts[*]}"
  }

  # inner function for shortened dir style - shows components up to max_length
  _get_shortened_dir() {
    local dir="${PWD/#$HOME/\~}"
    local out=""
    if ((${#dir} > max_length)); then
      local parts=()
      IFS='/' read -ra parts <<<"$dir"
      if ((${#parts[@]} > max_components)); then
        out="~/${BASHIFY_DIR_TRUNCATE_ICON}/${parts[-2]}/${parts[-1]}"
      else
        out="$dir"
      fi
    else
      out="$dir"
    fi
    # FIX: apply BASHIFY_DIR_COLOR_SHORTENED, which was defined but never used.
    # Lead with the shortened color so it overrides the BASHIFY_DIR_COLOR that the
    # outer printf prepends, and reset at the end.
    printf "%s" "${BASHIFY_DIR_COLOR_SHORTENED}${out}${BASHIFY_STYLE_RESET}"
  }

  # inner function for compact dir style - shows first letter of each directory
  _get_compact_dir() {
    local dir="${PWD/#$HOME/\~}"
    # FIX: handle root "/" so it is not swallowed by the empty-segment anchor case
    if [[ "$dir" == "/" ]]; then
      printf "%s" "${BASHIFY_DIR_COLOR_ANCHOR}/${BASHIFY_STYLE_RESET}"
      return
    fi
    local compact_parts=()
    local split=()

    IFS='/' read -ra split <<<"$dir"
    local last_index=$((${#split[@]} - 1))

    for i in "${!split[@]}"; do
      local segment="${split[i]}"
      if [[ "$segment" == "~" ]]; then
        compact_parts+=("~")
      elif ((i == last_index)); then
        compact_parts+=("${BASHIFY_DIR_COLOR_ANCHOR}${segment}${BASHIFY_STYLE_RESET}")
      elif [[ -n "$segment" ]]; then
        compact_parts+=("${segment:0:1}")
      fi
    done

    local IFS=/
    printf "%s" "${compact_parts[*]}"
  }

  # inner function for compact dir style - alternative method
  _get_compact_dir_alternative() {
    local dir="${PWD/#$HOME/\~}"
    # FIX: handle root "/" so it is not swallowed by the empty-segment anchor case
    if [[ "$dir" == "/" ]]; then
      printf "%s" "${BASHIFY_DIR_COLOR_ANCHOR}/${BASHIFY_STYLE_RESET}"
      return
    fi
    local compact_parts=()
    local split=()
    local compact_min_len="${BASHIFY_DIR_COMPACT_MIN_LEN:-3}"

    IFS='/' read -ra split <<<"$dir"
    local last_index=$((${#split[@]} - 1))

    for i in "${!split[@]}"; do
      local segment="${split[i]}"
      if [[ "$segment" == "~" ]]; then
        compact_parts+=("~")
      elif ((i == last_index)); then
        compact_parts+=("${BASHIFY_DIR_COLOR_ANCHOR}${segment}${BASHIFY_STYLE_RESET}")
      elif [[ -n "$segment" ]]; then
        local keep_len=$(( i < compact_min_len ? compact_min_len : i ))
        local seg_len=${#segment}
        if ((keep_len > seg_len)); then
          keep_len=$seg_len
        fi
        compact_parts+=("${segment:0:$keep_len}")
      fi
    done

    local IFS=/
    printf "%s" "${compact_parts[*]}"
  }

  # inner function for name dir style - shows only current directory name
  _get_name_dir() {
    printf "%s" "${BASHIFY_DIR_COLOR_ANCHOR}$(basename "$PWD")${BASHIFY_STYLE_RESET}"
  }

  # select the appropriate dir style based on configuration
  case "$path_style" in
  full)
    dir=$(_get_dir_path)
    ;;
  shortened)
    dir=$(_get_shortened_dir)
    ;;
  compact)
    dir=$(_get_compact_dir)
    ;;
  compactalt)
    dir=$(_get_compact_dir_alternative)
    ;;
  name | *)
    dir=$(_get_name_dir)
    ;;
  esac

  printf "%s" "${BASHIFY_DIR_COLOR}$dir${BASHIFY_STYLE_RESET} "
}

# git module - with performance caching, uses existing __git_ps1 if available
get_git_segment() {

  # helper function: check if git command is available and we're in a git repository
  _git_is_repo() {
    command -v git &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null 2>/dev/null
    return $?
  }

  # helper function: get current branch name
  _git_branch_name() {
    git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null
  }

  # helper function: get git status output (cached for performance)
  _git_status_output() {
    git status --porcelain 2>/dev/null
  }

  # helper function: get branch status counts (staged, modified, untracked, conflicted)
  # conflict pairs (UU, AA, DD, AU, UA, UD, DU) are pulled out first so they are
  # never double-counted as both staged and modified
  _git_status_counts() {
    local status_output="$1"
    local staged=0
    local modified=0
    local untracked=0
    local conflicted=0

    while IFS= read -r line; do
      [[ -z "$line" ]] && continue

      local first_char="${line:0:1}"
      local second_char="${line:1:1}"

      # count conflicted files first, then skip further classification
      if [[ "$first_char$second_char" =~ ^(UU|AA|DD|AU|UA|UD|DU)$ ]]; then
        ((conflicted++))
        continue
      fi

      # count staged files
      [[ "$first_char" =~ [MADRC] ]] && ((staged++))

      # count modified files
      [[ "$second_char" =~ [MADRC] ]] && ((modified++))

      # count untracked files
      [[ "$first_char" == "?" ]] && ((untracked++))

    done <<<"$status_output"

    printf "%d %d %d %d" "$staged" "$modified" "$untracked" "$conflicted"
  }

  # helper function: Format status indicators based on counts
  _git_format_status_indicators() {
    local staged=$1
    local modified=$2
    local untracked=$3
    local conflicted=$4
    local indicators=""

    # add conflicted files indicator first - they need the most attention
    if [[ "$conflicted" -gt 0 ]]; then
      indicators+=" ${BASHIFY_GIT_COLOR_CONFLICT}${BASHIFY_GIT_ICON_CONFLICT}${conflicted}${BASHIFY_STYLE_RESET}"
    fi

    # add staged changes indicator
    if [[ "$staged" -gt 0 ]]; then
      indicators+=" ${BASHIFY_GIT_COLOR_STAGED}${BASHIFY_GIT_ICON_STAGED}${staged}${BASHIFY_STYLE_RESET}"
    fi

    # add unstaged (modified) files indicator
    if [[ "$modified" -gt 0 ]]; then
      indicators+=" ${BASHIFY_GIT_COLOR_UNSTAGED}${BASHIFY_GIT_ICON_UNSTAGED}${modified}${BASHIFY_STYLE_RESET}"
    fi

    # add untracked files indicator
    if [[ "$untracked" -gt 0 ]]; then
      indicators+=" ${BASHIFY_GIT_COLOR_UNTRACKED}${BASHIFY_GIT_ICON_UNTRACKED}${untracked}${BASHIFY_STYLE_RESET}"
    fi

    # check if working directory is clean - only when nothing else, including conflicts, is set
    if [[ "$staged" -eq 0 && "$modified" -eq 0 && "$untracked" -eq 0 && "$conflicted" -eq 0 ]]; then
      indicators+=" ${BASHIFY_GIT_COLOR_CLEAN}${BASHIFY_GIT_ICON_CHECK}${BASHIFY_STYLE_RESET}"
    fi

    printf "%s" "$indicators"
  }

  # helper function: get stash count
  _git_stash_count() {
    local count
    count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
    printf "%s" "$count"
  }

  # helper function: format stash indicator
  _git_format_stash_indicator() {
    local stash_count=$1
    local indicator=""

    if [[ "$stash_count" -gt 0 ]]; then
      indicator=" ${BASHIFY_GIT_COLOR_STASH}${BASHIFY_GIT_ICON_STASH}${stash_count}${BASHIFY_STYLE_RESET}"
    fi

    printf "%s" "$indicator"
  }

  # helper function: get ahead/behind status for remote tracking branch
  _git_remote_status() {
    local remote_branch
    remote_branch=$(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)" 2>/dev/null)

    if [[ -z "$remote_branch" ]]; then
      printf "0 0" # no remote branch
      return
    fi

    local ahead_behind
    ahead_behind=$(git rev-list --left-right --count "$remote_branch"...HEAD 2>/dev/null)

    if [[ $? -ne 0 ]]; then
      printf "0 0" # error in git rev-list
      return
    fi

    local behind=$(printf "%s" "$ahead_behind" | awk '{print $1}')
    local ahead=$(printf "%s" "$ahead_behind" | awk '{print $2}')

    printf "%d %d" "$behind" "$ahead"
  }

  # helper function: format remote tracking indicator
  _git_format_remote_indicator() {
    local behind=$1
    local ahead=$2
    local indicator=""

    if [[ "$behind" -gt 0 || "$ahead" -gt 0 ]]; then
      indicator=" ${BASHIFY_GIT_COLOR_REMOTE}${BASHIFY_GIT_ICON_REMOTE}"
      [[ "$behind" -gt 0 ]] && indicator+="${BASHIFY_GIT_ICON_BEHIND}${behind}"
      [[ "$ahead" -gt 0 ]] && indicator+="${BASHIFY_GIT_ICON_AHEAD}${ahead}"
      indicator+="${BASHIFY_STYLE_RESET}"
    fi

    printf "%s" "$indicator"
  }

  # helper function: check for merge conflicts
  _git_has_conflicts() {
    local git_dir
    git_dir=$(git rev-parse --git-dir 2>/dev/null)

    if [[ -d "$git_dir/rebase-merge" || -d "$git_dir/rebase-apply" || -f "$git_dir/MERGE_HEAD" ]]; then
      printf "true"
    else
      printf "false"
    fi
  }

  # helper function: format conflict indicator
  _git_format_conflict_indicator() {
    local has_conflicts=$1
    local indicator=""

    if [[ "$has_conflicts" == "true" ]]; then
      indicator=" ${BASHIFY_GIT_COLOR_CONFLICT}${BASHIFY_GIT_ICON_WARNING}${BASHIFY_STYLE_RESET}"
    fi

    printf "%s" "$indicator"
  }

  # check if we're in a git repository
  if ! _git_is_repo; then
    return
  fi

  # get current branch name
  local branch
  branch=$(_git_branch_name)
  [[ -z "$branch" ]] && return

  # start with branch name
  local git_info="${BASHIFY_STYLE_BOLD}${BASHIFY_GIT_COLOR_BRANCH}${BASHIFY_GIT_ICON_BRANCH}${branch}${BASHIFY_STYLE_RESET}"

  # get status info efficiently (cached for performance)
  local status_output
  status_output=$(_git_status_output)

  # get and parse status counts
  local status_counts
  status_counts=$(_git_status_counts "$status_output")
  read -r staged modified untracked conflicted <<<"$status_counts"

  # add status indicators
  git_info+="$(_git_format_status_indicators "$staged" "$modified" "$untracked" "$conflicted")"

  # add stash indicator
  local stash_count
  stash_count=$(_git_stash_count)
  git_info+="$(_git_format_stash_indicator "$stash_count")"

  # add remote tracking indicator if enabled
  if [[ "$BASHIFY_GIT_SHOW_AHEAD_BEHIND" == "true" ]]; then
    local remote_status
    remote_status=$(_git_remote_status)
    read -r behind ahead <<<"$remote_status"
    git_info+="$(_git_format_remote_indicator "$behind" "$ahead")"
  fi

  # add conflict indicator - only when no per-file conflict was already counted,
  # so an in-progress merge/rebase with zero conflicted files still gets flagged
  # without duplicating the per-file indicator
  local has_conflicts
  has_conflicts=$(_git_has_conflicts)
  if [[ "$has_conflicts" == "true" && "$conflicted" -eq 0 ]]; then
    git_info+="$(_git_format_conflict_indicator "$has_conflicts")"
  fi

  printf "%s" "$git_info "
}

# prompt_char module - shows a character based on the last command's success
get_prompt_char_segment() {
  # FIX: use the exit code passed as $1, not $?. Inside the command-substitution
  # that builds this segment, $? reflects the subshell setup (always 0), not the
  # user's last command, so the char was always green. The caller already passes
  # "$last_exit_code" as $1 (same as get_status_segment).
  if [[ "$1" -eq 0 ]]; then
    printf "%s" "${BASHIFY_PROMPT_CHAR_COLOR_SUCCESS}${BASHIFY_PROMPT_CHAR_ICON}${BASHIFY_STYLE_RESET} "
  else
    printf "%s" "${BASHIFY_PROMPT_CHAR_COLOR_FAILURE}${BASHIFY_PROMPT_CHAR_ICON}${BASHIFY_STYLE_RESET} "
  fi
}

# status module - shows exit code when non-zero
get_status_segment() {
  local exit_code="$1"
  [[ "$exit_code" != 0 ]] && printf "%s" "${BASHIFY_STATUS_COLOR}[${BASHIFY_STATUS_ICON} $exit_code]${BASHIFY_STYLE_RESET} "
}

# jobs module - shows number of background jobs
get_jobs_segment() {
  local job_count
  # job_count=$(jobs -p | wc -l | tr -d " ")
  # job_count=$(jobs | grep -c "Running\|Stopped")
  job_count=0
  while IFS= read -r line; do
    [[ "$line" == *Running* || "$line" == *Stopped* ]] && ((job_count++))
  done < <(jobs)
  if ((job_count == 1)); then
    printf "%s" "${BASHIFY_JOBS_COLOR}${BASHIFY_STYLE_BLINK_ON}${BASHIFY_JOBS_ICON}${BASHIFY_STYLE_RESET} "
  elif ((job_count > 1)); then
    printf "%s" "${BASHIFY_JOBS_COLOR}${BASHIFY_STYLE_BLINK_ON}${BASHIFY_JOBS_ICON} ${job_count}${BASHIFY_STYLE_RESET} "
  fi
}

# node module - shows if in a nodejs project
get_node_segment() {
  local active_version=""
  local required_version=""
  local result=""
  local check=""
  local color="${BASHIFY_NODE_COLOR}"
  local icon="${BASHIFY_NODE_ICON}"

  # detect active Node.js version
  if command -v node &>/dev/null; then
    active_version=$(node -v | cut -c 2-)
  fi

  # build prompt segment if Node.js is available
  if [[ -n "$active_version" ]]; then
    # truncate to major.minor (e.g. 18.19)
    local short_version
    short_version=$(printf "%s" "$active_version" | cut -d. -f1,2)

    # extract required version only if key exists
    if [[ -f package.json ]]; then
      if command -v jq &>/dev/null; then
        required_version=$(jq -r 'try .engines.node // empty' package.json 2>/dev/null)
      else
        # portable fallback - avoids grep -P/\K which BSD grep lacks
        required_version=$(grep -o '"node"[[:space:]]*:[[:space:]]*"[^"]*"' package.json 2>/dev/null | grep -o '"[^"]*"$' | tr -d '"')
      fi
    fi

    # check compatibility only if required_version is valid
    if [[ -n "$required_version" && -n "$(command -v npx)" ]]; then
      check=$(npx --yes semver "$active_version" -r "$required_version" 2>/dev/null)

      if [[ -z "$check" ]]; then
        color="${BASHIFY_FG_YELLOW}"
        icon="${BASHIFY_GIT_ICON_WARNING}"
      fi
    fi

    result="${color}${icon} ${short_version}"

    # append source tag (@nv, @nd, etc.) only when enabled - computed lazily
    if [[ "$BASHIFY_NODE_SHOW_SOURCE" == true ]]; then
      local source=""
      case "$(command -v node)" in
      *nvm*) source="@nv" ;;                                # nvm-managed
      *nodenv*) source="@nd" ;;                             # nodenv-managed
      /usr/bin/node | /usr/local/bin/node) source="@sys" ;; # system-installed
      *) source="@?" ;;                                     # unknown source
      esac
      result+="${source}"
    fi

    result+="${BASHIFY_STYLE_RESET} "
    printf "%s" "$result"
  fi
}

# bashver module - shows bash version
get_bashver_segment() {
  local bashver=$(_bashify_get_bash_version)
  printf "%s" "${BASHIFY_BASHVER_COLOR}${BASHIFY_BASHVER_ICON} v${bashver}${BASHIFY_STYLE_RESET} "
}

# time module - shows current time
get_time_segment() {
  printf "%s" "${BASHIFY_TIME_COLOR}$(date +"%I:%M %p")${BASHIFY_STYLE_RESET} "
}

#############################################################################
# HELPER FUNCTIONS
#############################################################################

# get the short hostname - truncate to 12 chars if needed
_bashify_get_short_hostname() {
  local short_hostname="${HOSTNAME%%.*}"

  if [[ ${#short_hostname} -gt 12 ]]; then
    short_hostname="${short_hostname:0:12}"
  fi

  printf "%s" "$short_hostname"
}

# get the bash version - returns major.minor format
_bashify_get_bash_version() {
  local full_version
  full_version=$("$BASH" --version 2>/dev/null | head -n1)

  printf "%s" "$full_version" | sed -n 's/.*version \([0-9][0-9]*\.[0-9][0-9]*\).*/\1/p'
}

# set the terminal title - shows user@hostname and bash version
_bashify_set_terminal_title() {
  local hostname=$(_bashify_get_short_hostname)
  local bashver=$(_bashify_get_bash_version)
  printf "\033]0;%s@%s (bash v%s)\007" "${USER}" "${hostname}" "${bashver}"
}

# calculate visible length of string (without ANSI codes)
_bashify_visible_length() {
  local input="$1"
  input=$(printf "%s" "$input" | sed 's/\x1B\[[0-9;]*[a-zA-Z]//g')
  input=$(printf "%s" "$input" | sed 's/\\\[[^]]*\\\]//g')
  printf "%s" "$input" | wc -m | tr -d ' '
}

# handle terminal resize events
_bashify_handle_resize() {
  [[ -n "$INSIDE_RESIZE_HANDLER" ]] && return
  INSIDE_RESIZE_HANDLER=1
  set_bashify_prompt
  unset INSIDE_RESIZE_HANDLER
}

#############################################################################
# MAIN PROMPT BUILDER
#############################################################################

# main prompt builder - uses spaces to position right-side elements
set_bashify_prompt() {
  local last_exit_code=$? # get last command exit code

  # build left side of the prompt
  local prompt_left
  for module in "${BASHIFY_LEFT_PROMPT_ELEMENTS[@]}"; do
    local segment
    segment="$(get_${module}_segment "$last_exit_code")"
    [[ -n "$segment" ]] && prompt_left+="$segment"
  done

  # build right side of the prompt
  local prompt_right
  for module in "${BASHIFY_RIGHT_PROMPT_ELEMENTS[@]}"; do
    local segment
    segment="$(get_${module}_segment "$last_exit_code")"
    [[ -n "$segment" ]] && prompt_right+="$segment"
  done

  # right prompt is disabled either via config (BASHIFY_RIGHT_PROMPT_ENABLED=false)
  # or automatically when running inside a Docker container or dumb terminal
  if [[ "$BASHIFY_RIGHT_PROMPT_ENABLED" != "true" ]]; then
    export PS1="${prompt_left}"
    _bashify_set_terminal_title
    return
  fi

  # get terminal width in columns
  local terminal_width
  terminal_width="$(tput cols)"

  # calculate visible length of right side
  local prompt_right_length
  prompt_right_length=$(_bashify_visible_length "$prompt_right")

  # find column to right-align prompt
  local right_prompt_column=$((terminal_width - prompt_right_length + BASHIFY_RIGHT_PROMPT_OFFSET))
  ((right_prompt_column < 1)) && right_prompt_column=1

  # generate ansi-escaped right-aligned segment
  local aligned_right_prompt
  aligned_right_prompt=$(printf "\[\0337\]\[\033[%dG\]%s\[\0338\]" "$right_prompt_column" "$prompt_right")

  # build full prompt string
  export PS1="${prompt_left}${aligned_right_prompt}"

  # update terminal title if needed
  _bashify_set_terminal_title
}

#############################################################################
# ACTIVATION
#############################################################################

# set the prompt command to run our custom prompt builder
PROMPT_COMMAND=set_bashify_prompt

# handle terminal resize events to reformat prompt
trap '_bashify_handle_resize' SIGWINCH

## eof