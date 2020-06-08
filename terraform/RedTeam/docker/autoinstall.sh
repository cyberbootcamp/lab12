#!/bin/bash

until [[ $(which make) ]]
do
  echo waiting for make
  sleep 30
done

sleep 5

cd ~/docker && make start