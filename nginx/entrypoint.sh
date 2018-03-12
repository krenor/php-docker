#!/bin/sh

# Replace all template variables inside configuration files by:
#
# grabbing all the placeholders to replace,
# striping them from their delimiters
# and replacing them with the value from the environment variable with the same name.
for file in $(find /etc/nginx/conf.d -name '*.conf' -type f); do
    # TODO: Throw warning if env is not set.
    grep -o '%.*%' ${file} \
    | sed 's|%\(.*\)%|\1|' \
    | xargs -I {} sh -c "sed -i -e 's|%"{}"%|'$"{}"'|' $file"
done

# Execute `COMMAND` in the same shell as this script.
exec "$@"
