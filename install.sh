#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./install.sh [codex|claude|both] [--force] [--home PATH]

Installs matrix-task as a personal skill. The default target is both.
Existing installations are preserved unless --force is supplied.
EOF
}

target="both"
force="false"
install_home="${HOME:-}"

if [[ $# -gt 0 && "$1" != --* ]]; then
  target="$1"
  shift
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      force="true"
      ;;
    --home)
      shift
      if [[ $# -eq 0 ]]; then
        echo "--home requires a path" >&2
        exit 2
      fi
      install_home="$1"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

case "$target" in
  codex|claude|both) ;;
  *)
    echo "Target must be codex, claude, or both: $target" >&2
    exit 2
    ;;
esac

if [[ -z "$install_home" ]]; then
  echo "A home directory is required. Set HOME or pass --home PATH." >&2
  exit 2
fi

script_path="${BASH_SOURCE[0]//\\//}"
if [[ "$script_path" == */* ]]; then
  script_parent="${script_path%/*}"
else
  script_parent="."
fi
script_dir="$(cd -- "$script_parent" && pwd)"
skill_name="matrix-task"
required_file="$script_dir/SKILL.md"
optional_directories=(agents scripts references assets)

if [[ ! -f "$required_file" ]]; then
  echo "SKILL.md was not found beside this installer: $required_file" >&2
  exit 1
fi

install_skill() {
  local product="$1"
  local destination_root="$2"
  local destination="$destination_root/$skill_name"

  if [[ -e "$destination" && "$force" != "true" ]]; then
    echo "$product installation already exists at $destination. Re-run with --force to update it." >&2
    return 1
  fi

  mkdir -p "$destination"
  cp "$required_file" "$destination/SKILL.md"

  local directory_name
  for directory_name in "${optional_directories[@]}"; do
    if [[ -d "$script_dir/$directory_name" ]]; then
      mkdir -p "$destination/$directory_name"
      cp -R "$script_dir/$directory_name/." "$destination/$directory_name/"
    fi
  done

  echo "Installed matrix-task for $product at $destination"
}

if [[ "$target" == "codex" || "$target" == "both" ]]; then
  install_skill "Codex" "$install_home/.agents/skills"
fi

if [[ "$target" == "claude" || "$target" == "both" ]]; then
  install_skill "Claude Code" "$install_home/.claude/skills"
fi
