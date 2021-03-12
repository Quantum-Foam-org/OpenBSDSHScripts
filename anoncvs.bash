#!/bin/bash

. "../bash_library/lib/bash.bash"

BASH_LIBS="../bash_library/lib/"

add_lib "print.bash"
add_lib "file.bash"

IFS=$'\n\t'
OPENBSD_VERSION='OPENBSD_6_8'
CVS_SERVER='anoncvs@anoncvs4.usa.openbsd.org:/cvs'
CVS_UP="/usr/bin/cvs -d %s -q up -Pd -r%s"
RPATH=`realpath .`
CVS_OUT_DIR=`printf "%s/%s" "$RPATH" "logs"`
DATE_STAMP=`date '+%Y-%m-%d'`
CVS_PROMPT="OBSD"

ANON_CVS=(
	"Update src" 
	"Update ports" 
	"Update xenocara" 
	"Get AnonCVS Server" 
	"Change AnonCVS Server" 
	"Get OpenBSD Version" 
	"Change OpenBSD Version"
	)

print_message "Enter CVS repository to update"
while [ true ]
do
	print_choice "${ANON_CVS[@]}"
	print_prompt "$CVS_PROMPT"

	case "$BASH_LIB_PROMPT" in
		[1-3])
			CVS_CMD=`printf $CVS_UP "$CVS_SERVER" "$OPENBSD_VERSION"`
			let CHOICE=$BASH_LIB_PROMPT-1
			MSG=`printf "Updating %s" "${ANON_CVS[$CHOICE]}"`
			print_info "$MSG"
			case "$BASH_LIB_PROMPT" in
				1)
					`cd /usr/src`
				;;
				2)
					`cd /usr/ports`
				;;
				3)
					`cd /usr/xenocara`
				;;
			esac
			CVS_OUT=`bash -c "$CVS_CMD"`
			if [ $? -ne 0 ]
			then
				print_error "CVS command did not succeed"
			else 
				print_success "CVS command succeeded"
			fi
			CVS_OUT_FILE=`printf "%s/CVS_UPDATE_%s.txt" "$CVS_OUT_DIR" "$DATE_STAMP"` 
			write_file "$CVS_OUT" "$CVS_OUT_FILE"
			if [ $? -ne 0 ]
			then
				MSG=`printf "Unable to write CVS outut to log file %s" "$CVS_OUT_FILE"`
				print_error "$MSG"
			fi
		;;
		4)
			print_info "Current Anonymous CVS Server"
			print_info "$CVS_SERVER"
		;;
		5)
			print_message "Enter Anonymous CVS Server"
			print_prompt "$CVS_PROMPT"
			CVS_SERVER=$BASH_LIB_PROMPT
		;;
		6)
			print_info "Current OpenBSD Version"
			print_info "$OPENBSD_VERSION"
		;;
		7)
			print_message "Enter OpenBSD Version"
			print_prompt "$CVS_PROMPT"
			OPENBSD_VERSION=$BASH_LIB_PROMPT
		;;
		quit)
			print_message "Quit? (y/n)"
			print_prompt "$CVS_PROMPT"
			if [ ${BASH_LIB_PROMPT^^} == 'Y' ]
			then
				break;
			fi
		;;
		*)
			print_message "Please choose a choice from the below list.  Type 'quit' to quit the script."
		;;
	esac
done

