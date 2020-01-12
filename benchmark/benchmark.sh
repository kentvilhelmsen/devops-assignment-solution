#!/bin/bash

runID="${RANDOM}"
file="./test.docx"
uploads="99"
maxThreads='1'
collector=''

echo -e "Now processing $((${uploads}+1)) upload(s)\n"

for num in $(seq 0 "${uploads}")
do
                collector+="${num} "
                if [[ "$(echo "${collector}" | wc -w)" -lt "${maxThreads}" ]] && [[ "${num}" != "${uploads}" ]]
                then
                        continue
                fi

                for inner in ${collector}
                do
                        echo "Processing upload #${inner}"
			curl --silent -F "file=@./test.docx;filename=test${inner}-${runID}.docx" http://flask:30846/ > /dev/null
                done

                echo "Resetting collector"
                collector=''
done
