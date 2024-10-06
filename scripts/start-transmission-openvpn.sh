#!/bin/bash

# Start OpenVPN in the background
/etc/openvpn/start.sh &
openvpn_pid=$!

# Start Transmission
transmission-daemon --config-dir /etc/transmission/

# Wait for OpenVPN to exit or fail
wait $openvpn_pid

# If OpenVPN fails, log the error but don't stop Transmission
if [ $? -ne 0 ]; then
    echo "OpenVPN failed to connect. Transmission continues to run."
fi

# Keep container running
tail -f /dev/null
