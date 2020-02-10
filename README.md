## Context

Built for ICHack20. Original repo with collabs on [gitlab](https://gitlab.doc.ic.ac.uk/ab5518/ichack20). Submission on [Devpost](https://devpost.com/software/shopwise)

## Inspiration

Ethically sourced food, being healthier improving lives. Accelerating wellbeing and efficiency in a supermarket.

## What it does

It is a self-checkout supermarket service platform accessible to both small and large supermarkets. With functionality like: showing nutritional info, offering healthier alternatives, cheaper alternatives, a supply chain portal. We know this may lead to shop lifting. Utilising CISCO's Meraki API, we have created a synchronised item grabbing verification system. Where potential snapshots are stored. Also we created our own blockchain ecosystem with transparent transactions and a smart contract between different users to track stages in food production. This will directly feed into a REST API that can be queried and tied to the app.

## How we built it

We have a suite of micro-services running through a Python Flask backend deployed on Heroku. We started by defining the endpoints and building up the functionality on there. We used publicly available recipe, supermarket api's to collect data and Cisco's Meraki api to build the shop lifting detection system to pair with our easy scan basket feature. The front end is a native iOS application. To build the blockchain we used Kaleido an ethereal based blockchain management system and Solidity a smart contract programming language.

## Challenges we ran into
Block chain APIs were tough to understand and to interact with.

## Accomplishments that we're proud of

Developed a blockchain system to ethically and transparently track the supply chain of food.

## What we learned
How blockchains work, Python Flask, micro-services, using CISCO's Meraki API with a mosquitto server.

## What's next for ShopWise
Integrate security system to a client (supermarket or shop side) so they can access the cctv and snapshots. Also scale the block chain and have more reliable data, creating an easy logging service at each stage in the supply chain.

## Built With
```
camera, cisco, docker, flask, heroku, kaleido, meraki, python, solidity, swift, xcode
```
