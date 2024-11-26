# PokeCoin (PKC) Smart Contract

## Overview

`PokeCoin` is an ERC20 token smart contract built on the Ethereum blockchain. It allows for the creation, transfer, and burning of tokens. The contract is designed to ensure that only the owner can mint new tokens, while any user can transfer and burn their tokens.

## Features

- **ERC20 Standard**: Implements the ERC20 token standard for compatibility with various wallets and exchanges.
- **Minting**: Only the contract owner can mint new tokens.
- **Transfer**: Any user can transfer tokens to another address.
- **Burning**: Any user can burn their tokens, reducing the total supply.

## Contract Details

- **Token Name**: PokeCoin
- **Token Symbol**: PKC
- **Owner**: The address that deploys the contract is set as the initial owner.

## Functions

### Constructor

```solidity
constructor(address initialOwner)
```

- Initializes the token with a name and symbol.
- Sets the initial owner of the contract.

### Transfer

```solidity
function transfer(address _to, uint256 _value) public override returns (bool)
```

- Allows users to transfer tokens to another address.
- Returns `true` if the transfer is successful.

### Mint

```solidity
function mint(address to, uint256 amount) public onlyOwner
```

- Allows the owner to mint new tokens to a specified address.

### Burn

Inherits the burn functionality from `ERC20Burnable`, allowing users to burn their tokens.

## Usage

1. **Deploy the Contract**: Deploy the `PokeCoin` contract with the address of the initial owner.
2. **Mint Tokens**: The owner can mint tokens by calling the `mint` function.
3. **Transfer Tokens**: Users can transfer tokens using the `transfer` function.
4. **Burn Tokens**: Users can burn their tokens to reduce the total supply.

## Using the Program

To interact with the `PokeCoin` smart contract, follow these steps:

1. **Set Up Your Environment**:

   - Ensure you have a development environment set up with tools like [Truffle](https://www.trufflesuite.com/truffle) or [Hardhat](https://hardhat.org/).
   - Install the necessary dependencies, including OpenZeppelin contracts.

2. **Deploy the Contract**:

   - Write a deployment script that specifies the initial owner's address.
   - Use the command line to deploy the contract to your desired Ethereum network.

3. **Mint Tokens**:

   - Call the `mint` function from the owner's account to create new tokens.
   - Example: `pokeCoin.mint("recipient_address", amount);`

4. **Transfer Tokens**:

   - Any user can call the `transfer` function to send tokens to another address.
   - Example: `pokeCoin.transfer("recipient_address", amount);`

5. **Burn Tokens**:
   - Users can call the `burn` function to destroy their tokens.
   - Example: `pokeCoin.burn(amount);`

## License

This contract is licensed under the MIT License.
