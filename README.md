# Blend - A Simple Borrowing & Lending DeFi App

Welcome to **Blend**, a Decentralized Finance (DeFi) application designed to revolutionize the way we think about borrowing and lending. This application covers the essential aspects of DeFi by integrating smart contracts, blockchain interaction, and an intuitive front-end experience.

## Overview

Blend is a platform that enables decentralized lending through the use of Ethereum smart contracts. Users are able to deposit funds, borrow assets against collateral, repay loans, and withdraw their deposits. The application is built with Solidity for smart contract management and React for a responsive front-end user interface.

## Project Components

- **Smart Contract**: Developed in Solidity, this manages all critical functions such as deposits, borrows, repayments, and interest rate calculations.
- **Frontend Interface**: A React-based user interface that allows users to easily interact with the smart contract.
- **Web3.js**: Employed to facilitate the connection between the frontend and the Ethereum blockchain.

## Smart Contract Features

Our Solidity smart contracts provide the following functionalities:

- **Deposit**: Securely deposit Ether which updates the user balance and overall deposit pool.
- **Borrow**: Take out a loan with collateral, with the transaction details properly recorded.
- **Repay**: Fulfill loan obligations which updates the loan balance and the total debt.
- **Withdraw**: Retrieve deposited Ether and any collateral provided.
- **Interest Calculation**: Compute interest for both lenders and borrowers based on defined rates.

## Frontend Interface

Our React interface offers users the ability to:

- **Display Account Information**: View the connected Ethereum address and Ether balance.
- **Deposit Funds**: Make deposits in Ether into the Blend contract.
- **Borrow Funds**: Secure a loan by specifying the amount and collateral required.
- **Repay Loan**: Submit repayments for existing loans.
- **Withdraw Funds**: Withdraw your deposits and any collateral placed.

## Getting Started

To run this project locally, follow these steps:

1. **Clone the Repository**

   ```sh
   git clone https://github.com/your-username/Blend-a-Simple-Borrowing-Lending-DeFi-App.git
