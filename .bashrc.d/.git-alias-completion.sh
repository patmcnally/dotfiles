# Automatically create completion-aware g<alias> bash aliases for each of your git aliases.

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in l a cm s co cob b d la; do
    alias g$al="git $al"
    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done

