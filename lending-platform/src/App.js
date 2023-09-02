
//SIMPLE REACT JS APP 

import React, { useState, useEffect } from 'react';
import Web3 from 'web3';
import contractABI from './contractABI.json';

//Got When deployed/migrated with Ganache 
const contractAddress = "0xE0860ab9b56cDCF5F4c586c278B4CaEAB43613D2";

function App() {
  //VARIABLES DECLARATIONS
  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState(0);


  useEffect(() => {
    const init = async () => {
      if (window.ethereum) {

         // Initialize web3 instance
        const web3Instance = new Web3(window.ethereum);
        setWeb3(web3Instance);
        await window.ethereum.enable();

         // Get user account and balance
        const accounts = await web3Instance.eth.getAccounts();
        setAccount(accounts[0]);
        const balance = await web3Instance.eth.getBalance(accounts[0]);
        setBalance(web3Instance.utils.fromWei(balance, 'ether'));

         // Initialize contract instance
        const contractInstance = new web3Instance.eth.Contract(contractABI.abi, contractAddress);
        setContract(contractInstance);

      // Set up account change listener
        window.ethereum.on('accountsChanged', async (accounts) => {
          setAccount(accounts[0]);
          const balance = await web3Instance.eth.getBalance(accounts[0]);
          setBalance(web3Instance.utils.fromWei(balance, 'ether'));
        });
      }
    };


    init();
  }, []);


 const depositFunds = async (amount) => {
  // Check if contract and web3 are initialized
  if (!contract || !web3) {
    console.error("Contract or Web3 are not initialized yet.");
    return;
  }
  // Use the contract method to deposit funds
  await contract.methods.deposit().send({ from: account, value: web3.utils.toWei(amount, 'ether') });
};

const borrowFunds = async (amount, collateral) => {
  // Check if contract and web3 are initialized
  if (!contract || !web3) {
    console.error("Contract or Web3 are not initialized yet.");
    return;
  }
  // Use the contract method to borrow funds
  await contract.methods.borrow(amount).send({ from: account, value: web3.utils.toWei(collateral, 'ether') });
};

  const repayFunds = async (amount) => {
    // Check if contract and web3 are initialized
    if (!contract || !web3) {
      console.error("Contract or Web3 are not initialized yet.");
      return;
    }
    // Use the contract method to repay funds
    await contract.methods.repay(amount).send({ from: account, value: web3.utils.toWei(amount, 'ether') });
  };

  const withdrawFunds = async (amount) => {
    // Check if contract and web3 are initialized
    if (!contract || !web3) {
      console.error("Contract or Web3 are not initialized yet.");
      return;
    }
    // Use the contract method to withdraw funds
    await contract.methods.withdraw(amount).send({ from: account });
  };

  return (
    //Just a Simple Functional UI

    <div className="App">
      <h1> B-Lend' Platform</h1>
      <p>Account: {account}</p>
      <p>Balance: {balance} ETH</p>


      <h2>Deposit</h2>
      <button onClick={() => depositFunds('0.1')}>Deposit 0.1 ETH</button>

      <h2>Borrow</h2>
      <button onClick={() => borrowFunds('50000000000000000', '0.1')}>Borrow 0.05 ETH with 0.1 ETH collateral</button>

      <h2>Repay</h2>
      <button onClick={() => repayFunds('0.05')}>Repay 0.05 ETH</button>

      <h2>Withdraw</h2>
      <button onClick={() => withdrawFunds('50000000000000000')}>Withdraw 0.05 ETH</button>
    </div>
  );
}

export default App;
