# IdoloCoin Token Contract

A simple token contract for **IdoloCoin (IDL)** with minting and burning functions.

## Description

This contract creates a basic token called **IdoloCoin (IDL)**. It allows tracking balances of addresses, minting new tokens to an address, and burning tokens from an address. The total supply adjusts as tokens are minted or burned.


## Getting Started

### Installing

1. Open Remix IDE or any Solidity-supported IDE.
2. Paste the contract code into the editor.

### Running the Contract

1. Compile and deploy the contract in Remix.
2. Mint tokens:
   ```solidity
   mint("address", value);
   ```
3. Burn tokens:
   ```solidity
   burn("address", value);
   ```

## Help

Check Remix IDE for errors or insufficient gas issues.

## License

This project is licensed under the MIT License.