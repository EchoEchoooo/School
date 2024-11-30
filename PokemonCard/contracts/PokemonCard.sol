// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PokemonCard {
    mapping(address => string[]) private userCards;
    mapping(address => uint256) private userGoldCoins; // Track Gold Coins for each user
    mapping(uint256 => uint256) public goldCoinPrices; // Prices for different amounts of Gold Coins

    // Events
    event CardBought(address indexed buyer, string cardType, string cardName);
    event GoldCoinsPurchased(address indexed buyer, uint256 amount);

    // Modifier to check if the user has enough Gold Coins
    modifier hasEnoughGoldCoins(uint256 amount) {
        require(userGoldCoins[msg.sender] >= amount, "Not enough Gold Coins.");
        _;
    }

    constructor() {
        // Set prices in wei (1 ETH = 10^18 wei)
        goldCoinPrices[1] = 0.001 ether; // Price for 1 Gold Coin
        goldCoinPrices[5] = 0.004 ether; // Price for 5 Gold Coins
        goldCoinPrices[10] = 0.009 ether; // Price for 10 Gold Coins
        goldCoinPrices[20] = 0.019 ether; // Price for 20 Gold Coins
    }

    // Function to purchase Gold Coins
    function purchaseGoldCoins(uint256 _amount) external payable {
        require(
            _amount == 1 || _amount == 5 || _amount == 10 || _amount == 20,
            "Invalid Gold Coin amount"
        );
        require(
            msg.value == goldCoinPrices[_amount],
            "Incorrect ETH amount sent"
        );

        userGoldCoins[msg.sender] += _amount; // Add the purchased gold coins to the user's balance
        emit GoldCoinsPurchased(msg.sender, _amount);
    }

    // buy a common card (costs 5 Gold Coins)
    function buyCommonCard() external hasEnoughGoldCoins(5) {
        string memory cardName = getRandomCard("Common");
        userCards[msg.sender].push(cardName);
        userGoldCoins[msg.sender] -= 5; // Deduct Gold Coins
        emit CardBought(msg.sender, "Common", cardName);
    }

    // buy a rare card (costs 10 Gold Coins)
    function buyRareCard() external hasEnoughGoldCoins(10) {
        string memory cardName = getRandomCard("Rare");
        userCards[msg.sender].push(cardName);
        userGoldCoins[msg.sender] -= 10; // Deduct Gold Coins
        emit CardBought(msg.sender, "Rare", cardName);
    }

    // buy an uncommon card (costs 7 Gold Coins)
    function buyUncommonCard() external hasEnoughGoldCoins(7) {
        string memory cardName = getRandomCard("Uncommon");
        userCards[msg.sender].push(cardName);
        userGoldCoins[msg.sender] -= 7; // Deduct Gold Coins
        emit CardBought(msg.sender, "Uncommon", cardName);
    }

    // buy a rare holo card (costs 15 Gold Coins)
    function buyRareHoloCard() external hasEnoughGoldCoins(15) {
        string memory cardName = getRandomCard("Rare Holo");
        userCards[msg.sender].push(cardName);
        userGoldCoins[msg.sender] -= 15; // Deduct Gold Coins
        emit CardBought(msg.sender, "Rare Holo", cardName);
    }

    // buy a Pokémon EX card (costs 20 Gold Coins)
    function buyPokemonEXCard() external hasEnoughGoldCoins(20) {
        string memory cardName = getRandomCard("Pokemon EX");
        userCards[msg.sender].push(cardName);
        userGoldCoins[msg.sender] -= 20; // Deduct Gold Coins
        emit CardBought(msg.sender, "Pokemon EX", cardName);
    }

    // get the list of cards for the caller
    function getMyCards() external view returns (string[] memory) {
        return userCards[msg.sender];
    }

    // Function to check the user's Gold Coin balance
    function getGoldCoinBalance() external view returns (uint256) {
        return userGoldCoins[msg.sender];
    }

    // Internal function to get a random card based on card type
    function getRandomCard(
        string memory cardType
    ) internal pure returns (string memory) {
        // For simplicity, we'll return a fixed card here based on card type
        if (
            keccak256(abi.encodePacked(cardType)) ==
            keccak256(abi.encodePacked("Common"))
        ) {
            return "Pikachu";
        } else if (
            keccak256(abi.encodePacked(cardType)) ==
            keccak256(abi.encodePacked("Uncommon"))
        ) {
            return "Bulbasaur";
        } else if (
            keccak256(abi.encodePacked(cardType)) ==
            keccak256(abi.encodePacked("Rare"))
        ) {
            return "Charizard";
        } else if (
            keccak256(abi.encodePacked(cardType)) ==
            keccak256(abi.encodePacked("Rare Holo"))
        ) {
            return "Gyarados";
        } else if (
            keccak256(abi.encodePacked(cardType)) ==
            keccak256(abi.encodePacked("Pokemon EX"))
        ) {
            return "Mewtwo EX";
        } else {
            return "Unknown Card";
        }
    }
}
