#!/bin/bash

until [[ $(which docker) ]]
do
        echo 'waiting for docker'
        sleep 5
done

sleep 15