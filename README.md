# Validation Framework

There are two code files available in the repository. StorageContract.sol is a solidity contract which defines the rules and logic for the blockchain app. 
The Validations.py is Python code that uses Web3.py to interact with the smart contract. This allows users to send transactions to the smart contract, read data from the smart contract, and trigger functions in the smart contract

# Requirements
You will need to install a few libraries to use the code in the repository:

    Truffle: A blockchain development framework that provides tools to compile, deploy, and test Solidity contracts. You can install it using npm (Node Package Manager) by running npm install -g truffle.

    Web3.py: A Python library that allows you to connect to an Ethereum node and interact with the blockchain. You can install it using pip by running pip install web3.

    ipfshttpclient: A Python library that allows you to interact with IPFS. You can install it using pip by running pip install ipfshttpclient.

You will also need to have a local Ethereum node running (e.g., Ganache) and a local IPFS node running. Once you have installed the required libraries and set up the Ethereum and IPFS nodes, you should be able to run the Python program.
Here are the general steps to compile and deploy a Solidity contract on a computer in testing mode:

    Install a blockchain development framework such as Truffle, which will provide you with tools to compile, deploy, and test your Solidity contracts.

    Write your Solidity code in a .sol file.

    Compile your Solidity code using Truffle's truffle compile command. This will generate a JSON file that contains the contract's ABI (Application Binary Interface) and other information.

    Deploy your contract to a local blockchain using Truffle's truffle migrate command. This will create a new instance of your contract on the blockchain.

    Interact with your contract using Web3.py, a Python library that allows you to connect to a local or remote Ethereum node and interact with the blockchain. You can use the contract's ABI and address to create a Web3.py contract instance and call its functions from your Python program.
