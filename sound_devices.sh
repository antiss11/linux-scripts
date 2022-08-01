#!/bin/sh

# Variables PA_PORT_1, PA_PORT_2 and PA_SINK_NAME can be received from "pacmd list" command
# and added as environment variables for example in ~/.bashrc file.

ACTIVE_PORTS=$(pacmd list | grep 'active port')
if [[ $ACTIVE_PORTS == *"$PA_PORT_1"* ]];
then
    pacmd set-sink-port $PA_SINK_NAME $PA_PORT_2
else
    pacmd set-sink-port $PA_SINK_NAME $PA_PORT_1
fi