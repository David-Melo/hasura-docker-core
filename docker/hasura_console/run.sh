#!/bin/bash

cd /opt/hasura || {
    echo "Hasura folder '/opt/hasura' not found"
    exit 1
}

# temporal fix to workaround: https://github.com/hasura/graphql-engine/issues/2824#issuecomment-801293056
socat TCP-LISTEN:8080,fork TCP:hasura:8080 &
socat TCP-LISTEN:9695,fork,reuseaddr,bind=hasura_console TCP:127.0.0.1:9695 &
socat TCP-LISTEN:9693,fork,reuseaddr,bind=hasura_console TCP:127.0.0.1:9693 &
{
    # Apply migrations
    if [[ -v HASURA_APPLY_MIGRATIONS ]]; then
        echo "Applying Migrations & Metadata..."
        hasura metadata apply || exit 1
        hasura migrate apply --all-databases || exit 1
        hasura metadata reload || exit 1
    fi

    # Run console if specified
    if [[ -v HASURA_RUN_CONSOLE ]]; then
        echo "Starting console..."
        hasura console --log-level DEBUG --address "127.0.0.1" --no-browser || exit 1
    else
        echo "Started without console"
        tail -f /dev/null
    fi
}