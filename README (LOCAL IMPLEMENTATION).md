**Prerequisites:**

Node.js and npm: Make sure you have Node.js and npm (Node Package Manager) installed on your machine.
Steps to Set Up and Run the DApp

**Smart Contract:**

Create a new directory for your project and navigate to it in the terminal.
Inside the project directory, create a new directory called contracts.
Create a new Solidity file within the contracts directory, for example, LendingPlatform.sol.
Copy and paste the smart contract code into the LendingPlatform.sol file.

**Frontend:**

Inside the project directory, create a new directory called frontend.
Navigate to the frontend directory in the terminal: cd frontend.
Initialize a new React project: npx create-react-app lending-dapp.
Navigate to the new React project: cd lending-dapp.


**Smart Contract Deployment:**

Deploy the smart contract to a local development network using tools like Ganache or a testnet like Ropsten.
Make sure to note the contract address after deployment.
Connecting Frontend to Smart Contract
Inside the src directory of the React project (frontend/lending-dapp/src), replace the contents of App.js with the frontend code you have developed.
Update the contractAddress variable with the address of the deployed smart contract.
Install Dependencies and Run the DApp
Open a terminal and navigate to the frontend/lending-dapp directory.
Install the required dependencies: npm install.
Start the React development server: npm start.
Your default web browser should open, displaying the DApp's user interface.
If the browser doesn't open automatically, you can access the DApp by visiting http://localhost:3000 in your browser.


**Interacting with the DApp:**

Connect your MetaMask wallet to the local development network (Ganache or other) that you used to deploy the smart contract.
Import the accounts provided by your local development network into MetaMask.
You should see your account's address and balance displayed in the DApp.
Use the provided buttons to perform actions such as depositing, borrowing, repaying, and withdrawing funds.
Observe the changes in the DApp's interface and MetaMask as you interact with the smart contract.
