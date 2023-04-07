from web3 import Web3
import json

# Connect to the local Ethereum node
w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))

# Load the compiled contract ABI and bytecode
with open("build/contracts/HealthcareData.json") as f:
	contract_data = json.load(f)
abi = contract_data["abi"]
bytecode = contract_data["bytecode"]

# Deploy the contract
HealthcareData = w3.eth.contract(abi=abi, bytecode=bytecode)
tx_hash = HealthcareData.constructor().transact()
tx_receipt = w3.eth.waitForTransactionReceipt(tx_hash)
contract_address = tx_receipt.contractAddress

# Instantiate the deployed contract
healthcare_data = w3.eth.contract(address=contract_address, abi=abi)

# Store some personal data on-chain
data = "John Doe's medical records"
is_personal_or_sensitive = True
healthcare_data.functions.storeData(data, is_personal_or_sensitive).transact()

# Store some non-personal data off-chain
data = "billing details"
is_personal_or_sensitive = False
healthcare_data.functions.storeData(data, is_personal_or_sensitive).transact()

# Retrieve the stored data
data1 = healthcare_data.functions.getData(w3.eth.accounts[0], 0).call()
data2 = healthcare_data.functions.getData(w3.eth.accounts[0], 1).call()
print("Data 1: ", data1)
print("Data 2: ", data2)

# Calculate the storage costs
on_chain_cost, off_chain_cost = healthcare_data.functions.getStorageCost().call()
print("On-chain cost: ", on_chain_cost)
print("Off-chain cost: ", off_chain_cost)

# Aggregate some data and store it on-chain
data = ["10", "20", "30"]
is_personal_or_sensitive = False
healthcare_data.functions.aggregateData(data, is_personal_or_sensitive).transact()

# Retrieve the stored data
data3 = healthcare_data.functions.getData(w3.eth.accounts[0], 2).call()
print("Data 3: ", data3)
