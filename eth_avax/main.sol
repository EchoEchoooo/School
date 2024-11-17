// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SkinStore {
    struct Skin {
        address owner;
        bool isPurchased;
        uint256 price;
        string rarity;  // "common", "rare", "legendary"
        string name;
    }

    mapping(string => Skin) public skins;
    uint public constant TOTAL_SKINS = 10;
    mapping(address => uint256) public goldCoins;
    event GoldCoinsAdded(address indexed account, uint256 amount);
    event GoldCoinsSpent(address indexed account, uint256 amount);

    // Modifier to validate skin names
    modifier validSkinName(string memory skinName) {
        require(skins[skinName].price > 0, "Invalid skin name.");
        _;
    }

    constructor() {
        // Initialize common skins with gold prices instead of ETH
        initializeSkin("Pixel Pioneer", 100, "common");
        initializeSkin("Digital Drifter", 100, "common");
        initializeSkin("Neon Nomad", 100, "common");
        
        // Initialize rare skins
        initializeSkin("Quantum Quester", 300, "rare");
        initializeSkin("Cyber Sentinel", 300, "rare");
        initializeSkin("Void Voyager", 300, "rare");
        
        // Initialize legendary skins
        initializeSkin("Ethereal Eclipse", 500, "legendary");
        initializeSkin("Cosmic Conqueror", 500, "legendary");
        initializeSkin("Genesis Guardian", 500, "legendary");
    }

    function initializeSkin(string memory skinName, uint256 price, string memory rarity) private {
        skins[skinName] = Skin(address(0), false, price, rarity, skinName);
    }

    function purchaseSkin(string memory skinName) public validSkinName(skinName) {
        require(!skins[skinName].isPurchased, "Skin is already owned.");
        require(goldCoins[msg.sender] >= skins[skinName].price, "Insufficient gold coins.");

        // Deduct gold coins
        goldCoins[msg.sender] -= skins[skinName].price;
        
        skins[skinName] = Skin(
            msg.sender, 
            true, 
            skins[skinName].price, 
            skins[skinName].rarity,
            skinName
        );

        emit GoldCoinsSpent(msg.sender, skins[skinName].price);
        assert(skins[skinName].isPurchased == true);
    }

    function transferSkin(string memory skinName, address newOwner) public validSkinName(skinName) {
        require(skins[skinName].isPurchased, "Skin has not been purchased.");
        require(skins[skinName].owner == msg.sender, "Only skin owner can transfer.");
        require(newOwner != address(0), "Invalid recipient address.");

        skins[skinName].owner = newOwner;

        // Ensure the transfer was successful
        assert(skins[skinName].owner == newOwner);
    }

    function bulkPurchase(string[] memory skinNames) public {
        uint256 totalCost = 0;

        // Calculate total cost and validate skins
        for (uint i = 0; i < skinNames.length; i++) {
            string memory skinName = skinNames[i];
            
            if (skins[skinName].price == 0 || skins[skinName].isPurchased) {
                revert("One or more skins are invalid or already purchased.");
            }
            
            totalCost += skins[skinName].price;
        }

        require(goldCoins[msg.sender] >= totalCost, "Insufficient gold coins for bulk purchase.");

        // Deduct total cost
        goldCoins[msg.sender] -= totalCost;

        // Process purchases
        for (uint i = 0; i < skinNames.length; i++) {
            string memory skinName = skinNames[i];
            skins[skinName] = Skin(
                msg.sender, 
                true, 
                skins[skinName].price, 
                skins[skinName].rarity,
                skinName
            );
            assert(skins[skinName].isPurchased == true);
        }

        emit GoldCoinsSpent(msg.sender, totalCost);
    }

    function getOwnedSkinCount(address owner) public view returns (uint256) {
        uint256 count = 0;
        string[9] memory allSkinNames = [
            "Pixel Pioneer", "Digital Drifter", "Neon Nomad",
            "Quantum Quester", "Cyber Sentinel", "Void Voyager",
            "Ethereal Eclipse", "Cosmic Conqueror", "Genesis Guardian"
        ];
        
        for (uint i = 0; i < allSkinNames.length; i++) {
            if (skins[allSkinNames[i]].owner == owner) {
                count++;
            }
        }
        
        return count;
    }

    function addGoldCoins(address account, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        goldCoins[account] += amount;
        emit GoldCoinsAdded(account, amount);
    }

    function getGoldCoinsBalance(address account) public view returns (uint256) {
        return goldCoins[account];
    }
}

javascript

// Add 1000 gold coins to an account

await skinStore.addGoldCoins(userAddress, 1000);

// Purchase a single skin

await skinStore.purchaseSkin("Pixel Pioneer");

// Purchase multiple skins at once
await skinStore.bulkPurchase(["Pixel Pioneer", "Digital Drifter"]);

// Check gold coin balance
const balance = await skinStore.getGoldCoinsBalance(userAddress);

// Transfer a skin to another address
await skinStore.transferSkin("Pixel Pioneer", recipientAddress);

## Events

The contract emits the following events:
- `GoldCoinsAdded`: When gold coins are added to an account
- `GoldCoinsSpent`: When gold coins are spent on purchases

## Security Features

- Input validation for all functions
- Ownership verification for transfers
- Balance checks before purchases
- State validation using assertions
- Custom modifiers for skin name validation

## Requirements

- Solidity ^0.8.18
- Compatible with EVM-based networks

## License

This project is licensed under the MIT License.