// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PokemonCard {
    
    mapping(address => string[]) private userCards;

    // Events
    event CardBought(address indexed buyer, string cardType, string cardName);

    // Modifier to check the correct Ether amount for each card
    modifier correctPayment(uint256 price) {
        require(msg.value == price, "Incorrect ETH amount sent.");
        _;
    }

    // buy a common card (0.5 ETH)
    function buyCommonCard() external payable correctPayment(0.5 ether) {
        string memory cardName = getRandomCard("Common");
        userCards[msg.sender].push(cardName);
        emit CardBought(msg.sender, "Common", cardName);
    }

    // buy a rare card (1 ETH)
    function buyRareCard() external payable correctPayment(1 ether) {
        string memory cardName = getRandomCard("Rare");
        userCards[msg.sender].push(cardName);
        emit CardBought(msg.sender, "Rare", cardName);
    }

    // get the list of cards for the caller
    function getMyCards() external view returns (string[] memory) {
        return userCards[msg.sender];
    }

    // Internal function to get a random card based on card type
    function getRandomCard(string memory cardType) internal pure returns (string memory) {
        // For simplicity, we'll return a fixed card here based on card type
        if (keccak256(abi.encodePacked(cardType)) == keccak256(abi.encodePacked("Common"))) {
            return "Pikachu";
        } else if (keccak256(abi.encodePacked(cardType)) == keccak256(abi.encodePacked("Rare"))) {
            return "Charizard";
        } else {
            return "Unknown Card";
        }
    }
}
