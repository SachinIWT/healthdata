pragma solidity ^0.8.0;
contract HealthcareData {
	struct Data {
    	bool isPersonalOrSensitive;
    	bool isOffChain;
    	bytes32 hash;
    	string uri;
	}

	mapping(address => Data[]) private dataStore;

	function storeData(string memory data, bool isPersonalOrSensitive) public 
{
    		if (!isPersonalOrSensitive && bytes(data).length < 5000) 
{
        		// Store data on-chain
        		bytes32 hash = keccak256(bytes(data));
        		dataStore[msg.sender].push(Data(false, false, hash, ""));
    		} 
else
{
        		// Store hash of data on-chain in case of sensitive or big data
        		bytes32 hash = keccak256(bytes(data));
        		dataStore[msg.sender].push(Data(isPersonalOrSensitive, true, hash, ""));
        		// Store data off-chain
        		// Here we can implement to call a function to store the data off-chain,
        		// and return the URI where the data can be retrieved
        		// For the sake of simplicity, we'll just set the URI to the input data itself
        		dataStore[msg.sender][dataStore[msg.sender].length - 1].uri = data;
    		}
	}

	function getData(address user, uint256 index) public view returns (Data memory) {
    	return dataStore[user][index];
	}
// function to handle aggregatable data
	
	function aggregateData(string[] memory data, bool isPersonalOrSensitive) public 
{
    	require(data.length > 0, "No data provided");
    	require(data.length <= 100, "Maximum of 100 data points allowed");
    	uint256 gasLimit = gasleft();
    	string memory aggregateData = "";
    	for (uint256 i = 0; i < data.length; i++) {
        	aggregateData = string(abi.encodePacked(aggregateData, data[i]));
    	}
    	if (!isPersonalOrSensitive && bytes(aggregateData).length < 5000) 
{
        	// Store data on-chain
        	bytes32 hash = keccak256(bytes(aggregateData));
        	dataStore[msg.sender].push(Data(false, false, hash, ""));
        	gasLimit -= 65000; // Subtract gas cost of storing data on-chain
    	} else {
        	// Store hash of data on-chain
        	bytes32 hash = keccak256(bytes(aggregateData));
        	dataStore[msg.sender].push(Data(isPersonalOrSensitive, true, hash, ""));
        	// Store data off-chain
        	// Here we would typically call a function to store the data off-chain,
        	// and return the URI where the data can be retrieved
        	// For the sake of simplicity, we'll just set the URI to the input data itself
        	dataStore[msg.sender][dataStore[msg.sender].length - 1].uri = aggregateData;
        	gasLimit -= 110000; // Subtract gas cost of storing hash on-chain and storing data off-chain
    	}

function getStorageCost() public pure returns (uint256 onChainCost, uint256 offChainCost) 
{
    	// Assuming present costs of storage on leading blockchain platforms are as follows:
    	// On-chain: $x per KB per year , substitute with Gas Prices
    	// Off-chain: $y per GB per month , substitute with costs of your chosen platform
    	// Gas price on Ethereum as of April 2023: 85 Gwei (0.000000085 ETH)
    	onChainCost = computed; // This cost will be varying as per Gas Prices, 
    	offChainCost = computed; // Cost variable as per Offchain Platform
	}

    	// Refund remaining gas to user
