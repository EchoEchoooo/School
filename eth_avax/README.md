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
