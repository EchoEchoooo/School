/*
Assessment Requirements
1. Create a variable that can hold a number of NFT's. What type of variable might this be?
2. Create an object inside your mintNFT function that will hold the metadata for your NFTs.
   The metadata values will be passed to the function as parameters. When the NFT is ready,
   you will store it in the variable you created in step 1
3. Your listNFTs() function will print all of your NFTs metadata to the console (i.e. console.log("Name: " + someNFT.name))
4. For good measure, getTotalSupply() should return the number of NFT's you have created
*/

// create a variable to hold your NFT's
let myNFTs = [];

// this function will take in some values as parameters, create an
// NFT object using the parameters passed to it for its metadata,
// and store it in the variable above.
function mintNFT(name, value, creator) {
    let nft = {
        name: name,
        value: value,
        creator: creator
    };
    myNFTs.push(nft);
}

// create a "loop" that will go through an "array" of NFT's
// and print their metadata with console.log()
function listNFTs() {
    for (let i = 0; i < myNFTs.length; i++) {
        console.log("Name: " + myNFTs[i].name + " | Value: " + myNFTs[i].value + " | Creator: " + myNFTs[i].creator);
    }
}

// print the total number of NFTs we have minted to the console
function getTotalSupply() {
    console.log("Total number of NFT supply: " + myNFTs.length);
}

// call your functions below this line
mintNFT("IdoloCoin", 17421, "Juan");
mintNFT("MasterCoin", 23847, "Maria");
mintNFT("AsoCoin", 52412, "Domeng");
mintNFT("CatCoin", 72361, "Juswa");

listNFTs();
getTotalSupply();
