import { useState, useEffect } from "react";
import { ethers } from "ethers";
import pokemonCard_abi from "../artifacts/contracts/PokemonCard.sol/PokemonCard.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [pokemonCard, setPokemonCard] = useState(undefined);
  const [prizes, setPrizes] = useState([]);
  const [goldCoinBalance, setGoldCoinBalance] = useState(0);

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

  const purchaseGoldCoins = async (amount) => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.purchaseGoldCoins(amount, {
        value: ethers.utils.parseEther(goldCoinPrices[amount].toString()),
      });
      await tx.wait();
      alert(`${amount} Gold Coins purchased successfully!`);
      fetchGoldCoinBalance();
    } catch (error) {
      console.error("Transaction error", error);
    }
  };

  const goldCoinPrices = {
    1: 0.001,
    5: 0.004,
    10: 0.009,
    20: 0.019,
  };

  const buyCommonCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyCommonCard();
      await tx.wait();
      await fetchGoldCoinBalance();
      await getRewards();
    } catch (error) {
      console.error("Transaction error", error);
    }
  };

  const buyUncommonCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyUncommonCard();
      await tx.wait();
      await fetchGoldCoinBalance();
      await getRewards();
    } catch (error) {
      console.error("Transaction error", error);
    }
  };

  const buyRareCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyRareCard();
      await tx.wait();
      await fetchGoldCoinBalance();
      await getRewards();
    } catch (error) {
      console.error("Transaction error", error);
    }
  };

  const buyRareHoloCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyRareHoloCard();
      await tx.wait();
      await fetchGoldCoinBalance();
      await getRewards();
    } catch (error) {
      console.error("Transaction error", error);
    }
  };

  const buyPokemonEXCard = async () => {
    if (!pokemonCard) return;

    try {
      const tx = await pokemonCard.buyPokemonEXCard();
      await tx.wait();
      await fetchGoldCoinBalance();
      await getRewards();
    } catch (error) {
      console.error("Transaction error", error);
    }
  };

  // Fetch the user's Gold Coin balance
  const fetchGoldCoinBalance = async () => {
    if (pokemonCard) {
      const balance = await pokemonCard.getGoldCoinBalance();
      setGoldCoinBalance(balance.toString());
    }
  };

  // useEffect to fetch Gold Coin balance when pokemonCard changes
  useEffect(() => {
    fetchGoldCoinBalance();
  }, [pokemonCard]);

  const initUser = () => {
    // Check to see if user has Metamask
    if (!ethWallet) {
      return <p>Please install Metamask in order to use this App.</p>;
    }

    // Check to see if user is connected. If not, connect to their account
    if (!account) {
      return (
        <button onClick={connectAccount} style={buttonStyle}>
          Please connect your Metamask wallet
        </button>
      );
    }

    return (
      <div style={containerStyle}>
        <p>Your Account: {`...${account.toString().slice(-4)}`}</p>
        <h3>Your Gold Coin Balance: {goldCoinBalance}</h3>
        <h3>Purchase Gold Coins</h3>
        <div style={buttonGroupStyle}>
          <button onClick={() => purchaseGoldCoins(1)} style={buttonStyle}>Buy 1 Gold Coin</button>
          <button onClick={() => purchaseGoldCoins(5)} style={buttonStyle}>Buy 5 Gold Coins</button>
          <button onClick={() => purchaseGoldCoins(10)} style={buttonStyle}>Buy 10 Gold Coins</button>
          <button onClick={() => purchaseGoldCoins(20)} style={buttonStyle}>Buy 20 Gold Coins</button>
        </div>
        {account ? (
          <div style={cardButtonGroupStyle}>
            <button onClick={buyCommonCard} style={buttonStyle}>Buy Common Card (5 Gold)</button>
            <button onClick={buyUncommonCard} style={buttonStyle}>Buy Uncommon Card (7 Gold)</button>
            <button onClick={buyRareCard} style={buttonStyle}>Buy Rare Card (10 Gold)</button>
            <button onClick={buyRareHoloCard} style={buttonStyle}>Buy Rare Holo Card (15 Gold)</button>
            <button onClick={buyPokemonEXCard} style={buttonStyle}>Buy Pokémon EX Card (20 Gold)</button>
          </div>
        ) : (
          <p>Please Connect Account.</p>
        )}
        <hr />
        <h2>Your Cards</h2>
        <ul style={listStyle}>
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
  }, [pokemonCard]);

  return (
    <main className="container" style={mainStyle}>
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

// Styles
const mainStyle = {
  padding: '20px',
  backgroundColor: '#f9f9f9',
};

const containerStyle = {
  padding: '20px',
  borderRadius: '8px',
  boxShadow: '0 2px 10px rgba(0, 0, 0, 0.1)',
  backgroundColor: '#fff',
  margin: '20px auto',
  maxWidth: '600px',
};

const buttonStyle = {
  padding: '10px 15px',
  margin: '5px',
  border: 'none',
  borderRadius: '5px',
  backgroundColor: '#0070f3',
  color: '#fff',
  cursor: 'pointer',
  transition: 'background-color 0.3s',
};

const buttonGroupStyle = {
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
};

const cardButtonGroupStyle = {
  display: 'flex',
  flexWrap: 'wrap',
  justifyContent: 'center',
  gap: '10px',
};

const listStyle = {
  listStyleType: 'none',
  padding: '0',
};
