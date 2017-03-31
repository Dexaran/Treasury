# Treasury System

The main goal of Dexaran Treasury System was to build a platform for future DApps development that will incentivise all participants to promote / help each other to succeed. This will add more interaction between all involved DApps and help each of them to grow and progress.

Core Treasury System DApps are:
1. Treasury contract. (under development)
2. DEX token. (under development) 
3. Naming Service. ([experimental version finished](https://github.com/Dexaran/DNS))
4. Decentralized Exchange. ([under development](https://github.com/Dexaran/DecentralizedEXchange))

Treasury will be a smart-contract distributing dividends.

Token will be a smart-contract that will represent a value-accumulation currency, needed to distribute dividends.

Naming Service is a first DApp making users interaction with contracts and entire Ethereum platform easier. It will also help to promote other treasury DApps and will bring some income from registering names.

Decentralized Exchange will be a place where new DEX tokens can be claimed/traded. It will also bring an income from each trade 0.5% comission.

Every another DApp startup can be included in Treasury System at every time in future.

# Incentivisation

### For regular users/token holders
If even one of Treasury DApps will succeed it will bring an income in Treasury adding more value in DEX token. It makes every token holder interested in every new or already existing Treasury DApp success. DApps are not an abstract things to make people rich. They provide a kind of functional, for example Treasury Naming Service will make interaction with contracts/wallets easier for users by replacing hex-addresses with Names. It will also build an interface of interaction between replaceable contracts that will dicrease a chance of incorrigible errors. More useful DApps we will have, better the crypto-world will be.


### For contract/DApps developers
As every new DApp will bring more income and may increase DEX token value, it makes every already existing Treasury System participant interested in new DApp. For example if side DApp developers would provide any helpful functional for other Treasury DApps or output a part of their income in Treasury contract I can promote their DApp with my already existing Name Service UI, take part in their code review to prevent mistakes or provide any other possible assistance in their DApp development. And every other Treasury participant can do so.
Every successful DApp will add more value to DEX token, that will make more people interested.

# DEX token
DEX token is ERC23 token (but with no vulnerable `approval` function that will make DEX token more secure).
Its planned to launch a crowdsale when core Treasury DApps would be launched and Name Service will be upgraded.
140 000 DEX tokens would be sold from crowdsale.

### Monetary policy
DEX token is a one-time executable token. You can hold it as long as you want but you can claim your reward from Treasury only once. Executing of reward claiming will burn used tokens. This monetary policy considered to prevent of creating a permanent parasite draining funds from Treasury forever.
Since DEX token is burnable currency it will have minting. Every 2000 blocks 150 new DEX tokens will be issued and placed on Exchange where they can be bought at fixed price. If no one will buy new minted tokens or there will be a number of remaining tokens after 2000 blocks every unclaimed token will be burned. All funds from new tokens trade will instantly go to Treasury contract (i.e. redistributed between other DEX holders). It means if no one will claim rewards from Treasury, DEX token supply will double in avg 1 year. 
(5600 blocks ~ 1 day; avg 420 tokens/ day minted)

Monetary policy can be changed. The way of issuing and redistributing new DEX tokens can be changed.
Every DEX token minting is governed by Central Minter contract. So every other decentralized exchange may be allowed to mint tokens but only 200 tokens per 2000 blocks total could be minted.

As Treasury System founder I will receive 1% dev fee from tokens. I'm planning to redistribute 1% dev fee between treasury DApps developers to increase their incentivisation by another contract.

# Side DApps

Considering the option to include these DApps:
1. Smart Lottery. ([under development](https://github.com/Dexaran/Smart-Lottery) / delayed)
3. Decentralized smart-contract governed mining pool. (concept)

Treasury System DApps will output its income (or a part of its income) in a treasury-contract where DEX token holders would be able to convert their tokens into Ether benefiting from this DApps.
