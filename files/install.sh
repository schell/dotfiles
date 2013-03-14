#!/bin/bash

for f in .*
do
    echo "Hard linking $f to ~/$f..."
    ln $f ~/$f
done
echo "Done!"
