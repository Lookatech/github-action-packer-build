#!/bin/sh
set -e

WORKINGDIR=${INPUT_WORKINGDIR:-.}
TEMPLATE_FILE_NAME=${INPUT_TEMPLATEFILENAME:-packer.json}
VAR_LIST=${INPUT_VARLIST:-}
VAR_FILE_NAME=${INPUT_VARFILENAME:-}

# Set the working directory for the template
cd "${WORKINGDIR:-.}"

# Verify template file existence
if [[ ! -f "$TEMPLATE_FILE_NAME" ]]; then
  echo "${TEMPLATE_FILE_NAME} does not exit in the working directory (${WORKINGDIR})"
  exit 1
fi

# Concatenate arguments list
for i in $(echo $VAR_LIST | tr "," "\n")
do
  VAR_ARGUMENTS="-var '${i}' "$VAR_ARGUMENTS
done

# Add -var-file argument if exists
if [ ! -z "$VAR_FILE_NAME" ]; then
  if [ ! -f "$VAR_FILE_NAME" ]; then
    echo "${VAR_FILE_NAME} does not exit in the working directory (${WORKINGDIR})"
    exit 1
  fi
  VARFILE_ARGUMENTS="-var-file ${VAR_FILE_NAME}"
fi

set +e
# Execute command
OPERATION_OUTPUT=$(sh -c "packer build ${VAR_ARGUMENTS} ${VARFILE_ARGUMENTS} ${TEMPLATE_FILE_NAME}" 2>&1)
OPERATION_SUCCESS=$?
echo "$OPERATION_OUTPUT"
set -e

exit $OPERATION_SUCCESS