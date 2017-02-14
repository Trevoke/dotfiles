function fish_greeting
        set -x cow (ls -1 /usr/local/Cellar/cowsay/*/share/cows/*cow | awk 'BEGIN {srand(); OFMT="%.17f"} {print rand(), $0}' | cut -d ' ' -f2 | head -1)
        fortune | cowsay -f $cow -n
end
