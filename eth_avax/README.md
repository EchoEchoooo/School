# SkinStore Smart Contract

A Solidity smart contract for managing a digital skin marketplace using a custom gold coin currency system. Users can purchase, transfer, and manage various in-game skins using gold coins.

## Features

- Custom gold coin currency system
- Three tiers of skins: Common, Rare, and Legendary
- Single and bulk purchase options
- Skin ownership tracking
- Skin transfer functionality
- Balance checking system

## Skin Tiers & Pricing

### Common Skins (100 Gold Coins)

- Pixel Pioneer
- Digital Drifter
- Neon Nomad

### Rare Skins (300 Gold Coins)

- Quantum Quester
- Cyber Sentinel
- Void Voyager

### Legendary Skins (500 Gold Coins)

- Ethereal Eclipse
- Cosmic Conqueror
- Genesis Guardian

## Main Functions

### Currency Management

- `addGoldCoins(address account, uint256 amount)`: Add gold coins to an account
- `getGoldCoinsBalance(address account)`: Check gold coin balance of an account

### Skin Management

- `purchaseSkin(string memory skinName)`: Purchase a single skin
- `bulkPurchase(string[] memory skinNames)`: Purchase multiple skins at once
- `transferSkin(string memory skinName, address newOwner)`: Transfer skin ownership
- `getOwnedSkinCount(address owner)`: Check how many skins an address owns

## Usage Examples

### Adding Gold Coins

javascript
// Add 1000 gold coins to an account
await skinStore.addGoldCoins(userAddress, 1000);

### Purchasing a Skin

javascript
// Purchase a single skin
await skinStore.purchaseSkin("Pixel Pioneer");

### Bulk Purchase

javascript
// Purchase multiple skins at once
await skinStore.bulkPurchase(["Pixel Pioneer", "Digital Drifter"]);

### Checking Balance

javascript
// Check gold coin balance
const balance = await skinStore.getGoldCoinsBalance(userAddress);

### Transferring Skins

javascript
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
