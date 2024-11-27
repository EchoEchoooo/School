# DegenToken

## Description

The `DegenToken` smart contract is an innovative token system that allows users to mint, burn, and transfer tokens, as well as redeem them for collectible cards. The contract features five unique cards, each with its own price and limited quantity. Users can purchase these cards by burning the required amount of tokens, creating an engaging and interactive experience.

## Prerequisites

- Any JavaScript IDE with Node.js installed
- Metamask wallet connected to the Ethereum network (or any compatible test network)
- Etherscan (or equivalent) for transaction tracking
- Remix IDE for contract deployment

## Getting Started

### Installing

1. Clone this repository to your local machine.

   ```bash
   git clone <repository-url>  # Copy it from the drop-down green code button on the repo
   ```

2. Open the terminal in your preferred JavaScript IDE and run:

   ```bash
   npm install
   ```

### Executing the Program

1. In the terminal, type the following command to deploy the contract and get your address:

   ```bash
   npx hardhat run scripts/deploy.js --network <network-name>
   ```

2. Open your browser and navigate to the appropriate block explorer (e.g., Etherscan) to paste your address in the search bar and view your transaction history.

3. Open your contract in `Remix` to deploy it.

4. In the "Deploy and Run Transactions" section, select "Injected Web3" to connect your Metamask wallet as the transaction address.

5. Enter your contract address in the "At Address" field and click "Deploy."

6. You are now ready to interact with the contract. Use the drop-down menu to access the available functions.

### Contract Interaction

- **Mint Function**: As the owner, you can add tokens to your Metamask wallet.
- **Burn Function**: Users can burn their tokens in any amount.
- **Transfer Function**: Users can send tokens to another address.
- **Redeem Function**: Users can redeem cards from the store, which will burn the required tokens and deduct the card's quantity.
- **Get Inventory**: Users can check their inventory of redeemed cards.
- **Check Balance**: Users can check their token balance.
- **Get Card Function**: Users can retrieve details of a specific card (name, price, & quantity).

## Help

- Ensure that your Metamask wallet is connected to the correct network.
- Create an `.env` file for your API wallet's private key if necessary.

## Games and Anime References

- `Pikachu` from Pokémon
- `Charizard` from Pokémon
- `Bulbasaur` from Pokémon
- `Squirtle` from Pokémon
- `Mewtwo` from Pokémon

## Author

[Your Name]  
[Your GitHub Profile URL]

## License

This project is licensed under the MIT License.
