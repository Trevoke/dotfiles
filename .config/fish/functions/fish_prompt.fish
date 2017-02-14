function fish_prompt
        echo " "
        set_color yellow
        date "+%F %R %z"
        set_color green
        echo -n (whoami)
        set_color normal
        echo -n "@"
        set_color blue
        echo -n (hostname)
        set_color normal
        echo -n ":"
        set_color yellow
        echo -n (prompt_pwd)
        set_color normal
        echo -n '$ '
end
