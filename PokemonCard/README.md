# Pokémon Card Shop

A project that interacts with a Solidity smart contract from a JavaScript frontend using the ethers.js library.

## Description

This project implements a Pokémon Card smart contract in Solidity, where users can buy Pokémon cards with Ether and receive random cards. The JavaScript frontend uses the ethers.js library to interact with the smart contract, allowing users to connect their MetaMask wallet, purchase cards, and view their collection.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) installed
- MetaMask browser extension

### Installing

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. Install the dependencies:

   ```bash
   npm install
   ```

3. Compile and deploy the smart contract using Hardhat or any Ethereum development framework:

   ```bash
   npx hardhat compile
   npx hardhat run scripts/deploy.js --network localhost
   ```

4. Update the `contractAddress` in the frontend code with the address of the deployed Pokémon Card contract.

### Executing program

1. Start the local Ethereum node (e.g., Hardhat):

   ```bash
   npx hardhat node
   ```

2. Connect your MetaMask wallet to the local network.

3. Launch the frontend:

   ```bash
   npm run dev
   ```

4. Open your web browser and go to `http://localhost:3000`.

5. Connect your MetaMask wallet and interact with the Pokémon Card app to buy cards and view your collection.

### Card Purchase Costs

- **Common Card**: 5 Gold Coins
- **Uncommon Card**: 7 Gold Coins
- **Rare Card**: 10 Gold Coins
- **Rare Holo Card**: 15 Gold Coins
- **Pokémon EX Card**: 20 Gold Coins

## Help

If you encounter issues with the project, consider the following steps:

- Ensure that MetaMask is correctly connected to your local Ethereum network.
- Check that the smart contract is correctly deployed and the address in the frontend matches.
- Review the console logs for any errors in transactions or interaction with the contract.

## License

This project is licensed under the MIT License.
