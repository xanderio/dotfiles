function fish_title
    if [ $_ = fish ]
        echo (pwd)
    else
        echo (status current-command)
    end
end
