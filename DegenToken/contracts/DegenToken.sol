// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    struct Card {
        string id;
        string name;
        uint256 price;
        uint256 quantity;
    }

    Card[5] public cards;

    // Mapping for card inventories
    mapping(address => string[]) playerInventories;

    // Constructor to initialize the token and card store
    constructor(
        address initialOwner
    ) ERC20("Degen", "DGN") Ownable(initialOwner) {
        cards[0] = Card("0", "Pikachu", 70, 3);
        cards[1] = Card("1", "Charizard", 100, 2);
        cards[2] = Card("2", "Bulbasaur", 50, 6);
        cards[3] = Card("3", "Squirtle", 45, 10);
        cards[4] = Card("4", "Mewtwo", 990, 1);
    }

    // Mint tokens
    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        _mint(to, amount);
    }

    // Burn tokens
    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Transfer tokens to another address
    function transfer(
        address to,
        uint256 amount
    ) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    event CardRedeemed(address indexed player, string cardId);

    function redeem(uint256 cardId) external {
        require(cardId < cards.length, "Card does not exist");
        Card storage card = cards[cardId];
        require(card.quantity > 0, "Card out of stock");
        require(balanceOf(msg.sender) >= card.price, "Insufficient tokens");

        // Deduct the card's price in tokens
        _burn(msg.sender, card.price);
        card.quantity -= 1;

        // Card will add to player's inventory after redeeming it
        playerInventories[msg.sender].push(card.id);

        emit CardRedeemed(msg.sender, card.id);
    }

    // Player's inventory
    function getInventory() public view returns (string[] memory) {
        return playerInventories[msg.sender];
    }

    // View details of card
    function getCard(
        uint256 cardId
    )
        public
        view
        returns (string memory name, uint256 price, uint256 quantity)
    {
        require(cardId < cards.length, "Invalid card ID");
        Card storage card = cards[cardId];
        return (card.name, card.price, card.quantity);
    }

    // Check the balance
    function checkBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
