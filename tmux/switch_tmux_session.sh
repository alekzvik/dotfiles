#/usr/bin/env bash
set -e
prompt="session> "
tmux='/usr/bin/env tmux'

session_finder() {
	fzf_out=$($tmux ls -F '#{session_name}' | grep -v '^1' | sort -r | perl -pe 's/^0 [0-9]+//' | fzf --height=100% --print-query --prompt="$prompt" || true)
	line_count=$(echo "$fzf_out" | wc -l)
	session_name=$(echo "$fzf_out" | tail -n1)
	command=$(echo "$session_name" | awk '{ print $1 }')

	if [ $line_count -eq 1 ]; then
		unset TMUX
		word_count=$(echo "$fzf_out" | wc -w)
		if [ $word_count -eq 1 ]; then
			$tmux new-session -d -s $session_name
			$tmux switch-client -t $session_name
		else
			session_name=$(echo "$fzf_out" | tail -n1 | awk '{ print $2 }')
			case "$command" in
				":new")
					$tmux new-session -d -s $session_name
					$tmux switch-client -t $session_name
					;;
				":rename")
					$tmux rename-session $session_name
					;;
			esac
		fi
	else
		$tmux switch-client -t $session_name
	fi
	sleep 0.1
	$tmux refresh-client -S
}
session_finder
