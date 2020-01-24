#
# Verifies crc32 of given file to file name hash
# ONLY FOR VALIDATING DOWNLOAD FILE NOT CORRUPTED/INCOMPLETE
#
# Expected:   	return passed if crc32 equals filename chucksum value
# Unexpected: 	return failed if crc32 does not equal to filename checksum
#
# Mohamed Omar 24 Jan 2020
# GitHub: redomar

function verify
    set -lx crcVal (crc32 $argv | tr a-z A-Z  | grep -Ee '[0-9A-F]{8}' -o)
    set -lx fileVal (ls $argv | grep -Ee '[0-9A-F]{8}' -o)
    if test -z "$fileVal"
	echo 'No Checksum value in file name:' $argv 
    else if test $crcVal = $fileVal 
	echo 'Checksum Passed:' $crcVal '=' $fileVal 
    else
	echo 'Checksum Failed:' $crcVal '!=' $fileVal
	echo -e '\e[0;31;5m UNSAFE'
    end
end
