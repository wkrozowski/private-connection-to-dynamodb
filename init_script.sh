#!/bin/bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node
npm install aws-sdk
curl https://raw.githubusercontent.com/wkrozowski/private-connection-to-dynamodb/main/script.js -O

node script.js