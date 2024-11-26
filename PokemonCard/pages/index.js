import { useState, useEffect } from "react";
import { ethers } from "ethers";
import pokemonCard_abi from "../artifacts/contracts/PokemonCard.sol/PokemonCard.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [pokemonCard, setPokemonCard] = useState(undefined);
  const [prizes, setPrizes] = useState([]);

  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const pokemonABI = pokemonCard_abi.abi;

  // connect with metamask wallet and get account
  const getWallet = async () => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const account = await ethWallet.request({ method: "eth_accounts" });
      handleAccount(account);
    }
  };

  const handleAccount = (account) => {
    if (account) {
      console.log("Account connected: ", account);
      setAccount(account);
    } else {
      console.log("No account found");
    }
  };

  const connectAccount = async () => {
    if (!ethWallet) {
      alert("MetaMask wallet is required to connect");
      return;
    }

    const accounts = await ethWallet.request({ method: "eth_requestAccounts" });
    handleAccount(accounts);

    // once wallet is set we can get a reference to our deployed contract
    await getPokemonCardContract();
  };

  const getPokemonCardContract = async () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const cardContract = new ethers.Contract(contractAddress, pokemonABI, signer);

    setPokemonCard(cardContract);
  };

  const getRewards = async () => {
    if (pokemonCard) {
      setPrizes(await pokemonCard.getMyCards());
    }
  };

  const buyCommonCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyCommonCard({
        value: ethers.utils.parseEther("0.5"),
      });
      await tx.wait();
    } catch (error) {
      console.error("Transaction error", error);
    }

    getRewards();
  };

  const buyRareCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyRareCard({
        value: ethers.utils.parseEther("1"),
      });
      await tx.wait();
    } catch (error) {
      console.error("Transaction error", error);
    }

    getRewards();
  };

  const initUser = () => {
    // Check to see if user has Metamask
    if (!ethWallet) {
      return <p>Please install Metamask in order to use this App.</p>;
    }

    // Check to see if user is connected. If not, connect to their account
    if (!account) {
      return (
        <button onClick={connectAccount}>
          Please connect your Metamask wallet
        </button>
      );
    }

    return (
      <div>
        <p>Your Account: {`...${account.toString().slice(-4)}`}</p>
        {account ? (
          <div
            style={{
              display: "flex",
              gap: "10px",
              justifyContent: "center",
            }}
          >
            <button onClick={buyCommonCard}>Buy Common Card</button>
            <button onClick={buyRareCard}>Buy Rare Card</button>
          </div>
        ) : (
          <p>Please Connect Account.</p>
        )}
        <hr />
        <h2>Your Cards</h2>
        <ul>
          {prizes.map((card, index) => (
            <li key={index}>{card}</li>
          ))}
        </ul>
      </div>
    );
  };

  useEffect(() => {
    getWallet();
    
  }, []);

  useEffect(() => {
    getRewards();
  }, [pokemonCard])

  return (
    <main className="container">
      <header>
        <h1>Welcome to Pokémon Card Shop!</h1>
      </header>
      {initUser()}
      <style jsx>
        {`
          .container {
            text-align: center;
            font-family: Arial;
          }
          body {
            font-family: Arial;
          }
        `}
      </style>
    </main>
  );
}
