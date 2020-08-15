# This sets up a periodic locking of the bitwarden session (every 5 minutes)
export precmd_functions=('bwtimecheck')

bwtimecheck() {
	if [[ $(date +%s) > $lock_time ]]; then
		unset BW_SESSION
	fi
}

bwunlock() {
	bw unlock --check &> /dev/null
	if [[ $? = 1 ]]; then
		for i in {1..3}; do
			sessionId=$(bw unlock --raw)
			if [ "$sessionId" != "" ]; then
				export BW_SESSION=$sessionId
				export lock_time=$(date +%s --date="+5 minutes")
				return 0
			fi
		done
		echo "You suck!"
		return 1
	fi
}

bwget() {
	bwunlock
	if output=$(bw get password $1 2>&1); then
		echo "Copied to clipboard"
		echo $output | wl-copy
	else
		# if there are multiple or no results
		echo $(echo $output | head -1 | cut -d "." -f 1)
		for id_num in $(echo $output | tail -n +2); do
			# output name
			name=$(bw get item $id_num | jq | grep \"name\" | cut -d "\"" -f 4)
			printf "%s: %s\n" "${name}" "${id_num}"
			#bw get password $id_num
		done
	fi
}

bwcreate() {
	if [ "$1" != "" ]; then
		bwunlock
		name=$1
		username=${2:=""}
		length=${3:=25}
		characters=${4:=ulsn}
		bw get template item | jq ".name = \"${name}\"" | jq ".login = { \"username\": \"${username}\", \"password\": \"$(bw generate -${characters} --length ${length})\" }" | bw encode | bw create item
	else
		echo "No name provided\nbwcreate <name> [username] [length] [characters]"
		 
	fi
}

