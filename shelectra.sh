#!/bin/bash

NC="\033[0m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
MAGENTA="\033[0;35m"

BANNER="
███████╗██╗  ██╗███████╗██╗     ███████╗ ██████╗████████╗██████╗  █████╗ 
███╔═══╝██║  ██║██╔════╝██║     ██╔════╝██╔════╝╚══██╔══╝██╔══██ ██╔══██╗
  ███╗  ███████║█████╗  ██║     █████╗  ██║        ██║   █████╔╝ ███████║
    ███╗██╔══██║██╔══╝  ██║     ██╔══╝  ██║        ██║   ██  ██╗ ██╔══██║
███████║██║  ██║███████╗███████╗███████╗╚██████╗   ██║   ██║  ██╗██║  ██║
╚══════╝╚═╝  ╚═╝═══════╝╚══════╝╚══════╝ ╚═════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ v0.1

ShElectra - The master plan plotter (in shell/bash).
"

show_banner() {
    echo -e "${MAGENTA}${BANNER}${NC}"
}

show_help() {
    show_banner
    echo -e "Available Commands:"
    echo -e ""
    echo -e "help | Show this help message."
    echo -e "cdir | Create a new directory in a specified path."
    echo -e ""
    echo -e "Usage: bash $0 <command> [options]"
}

#CDIR
cdir() {
    local name=$1
    local path=$2

    if [[ "$(uname)" != "Linux" ]]; then
        echo -e "${RED}[!] This function is only supported on Linux systems.${NC}"
        exit 1
    fi

    if [[ -z "$path" ]]; then
        path=$(pwd)
        echo -e "${YELLOW}[!] No path specified. Using current directory: $path${NC}"
    fi

    local full_path="$path/$name"

    if mkdir -p "$full_path" 2>/dev/null; then
        echo -e "${GREEN}[!] Directory: '$name' created successfully at $full_path${NC}"
    else
        echo -e "${RED}[!] Error: Permission denied or directory already exists.${NC}"
    fi
}

#Main CLI
case "$1" in
    cdir)
        shift
        name="Directory"
        path=""
        while [[ $# -gt 0 ]]; do
            case "$1" in
                -n|--name)
                    name="$2"
                    shift 2
                    ;;
                -p|--path)
                    path="$2"
                    shift 2
                    ;;
                *)
                    echo -e "${RED}[!] Unknown option: $1${NC}"
                    exit 1
                    ;;
            esac
        done
        cdir "$name" "$path"
        ;;
    help|-h|--help|"")
        show_help
        ;;
    *)
        echo -e "${RED}[!] Unknown command: $1${NC}"
        show_help
        ;;
esac