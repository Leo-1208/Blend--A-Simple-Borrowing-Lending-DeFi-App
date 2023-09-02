// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract LendingPlatform {

    // Mapping to store user deposits, borrows, and collaterals
    mapping(address => uint256) public deposits; 
    mapping(address => uint256) public borrows;  
    mapping(address => uint256) public collaterals; 

    // Declaring Variables to store Total amounts
    uint256 public totalDeposits;
    uint256 public totalBorrows;
    uint256 public totalCollaterals;

    // Declaring Variables to store Interest Rate
    uint256 public constant borrowerInterestRate = 8; // Annual, in percentage to be received
    uint256 public constant lenderInterestRate = 5; // Annual, in percentage to be lent
    uint256 public lastInterestUpdate; // Timestamp

    // Declaring Events for deposit, borrow, repay, and withdraw actions
    event Deposited(address indexed user, uint256 amount);
    event Borrowed(address indexed user, uint256 amount);
    event Repaid(address indexed user, uint256 amount);
    event Withdrew(address indexed user, uint256 amount);

    constructor() {
        lastInterestUpdate = block.timestamp;
    }

    // Deposit function to add funds to the contract
    function deposit() external payable {
        updateInterest();
        deposits[msg.sender] += msg.value;
        totalDeposits += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Borrow function for loan
    function borrow(uint256 amount) external payable {
        updateInterest();
        require(totalDeposits - totalBorrows >= amount, "Not enough liquidity");
        require(msg.value >= amount / 2, "Insufficient collateral");

        collaterals[msg.sender] += msg.value;
        totalCollaterals += msg.value;

        borrows[msg.sender] += amount;
        totalBorrows += amount;

        payable(msg.sender).transfer(amount);
        
        emit Borrowed(msg.sender, amount);
    }

    // Repay function to pay back a loan
    function repay(uint256 amount) external payable {
        updateInterest();
        require(borrows[msg.sender] >= amount, "You don't owe this much");

        borrows[msg.sender] -= amount;
        totalBorrows -= amount;
        emit Repaid(msg.sender, amount);
    }

    // Withdraw function to withdraw funds and revert collateral
    function withdraw(uint256 amount) external {
        updateInterest();
        require(deposits[msg.sender] >= amount, "Insufficient balance");

        deposits[msg.sender] -= amount;
        totalDeposits -= amount;

        uint256 collateralToReturn = collaterals[msg.sender];
        collaterals[msg.sender] = 0;
        totalCollaterals -= collateralToReturn;

        payable(msg.sender).transfer(amount + collateralToReturn);
        
        emit Withdrew(msg.sender, amount + collateralToReturn);
    }

    // Update interest based on time elapsed 
    function updateInterest() public {

        // Calculate the time that has elapsed since the last interest update
        uint256 timeSinceLastUpdate = block.timestamp - lastInterestUpdate;

        // Only proceed if there has been some time elapsed
        if (timeSinceLastUpdate > 0) {
            uint256 borrowerExtra = (totalBorrows * borrowerInterestRate * timeSinceLastUpdate) / (365 days * 100);
            uint256 lenderExtra = (totalDeposits * lenderInterestRate * timeSinceLastUpdate) / (365 days * 100);

            // If both borrows and deposits are present and
            // ensure borrower interest is higher than lender interest(not necessary actually)

            if (totalBorrows > 0 && totalDeposits > 0) {
                require(borrowerExtra >= lenderExtra, "Borrower interest must be greater than lender interest");
                totalBorrows += borrowerExtra;
                totalDeposits += lenderExtra;

            // If only deposits are present, update deposits with lender interest
            } else if (totalDeposits > 0) {
                totalDeposits += lenderExtra;
            } else if (totalBorrows > 0) {  // If only borrows are present, update borrows with borrower interest
                totalBorrows += borrowerExtra;
            }

            // Update the timestamp of the last interest update
            lastInterestUpdate = block.timestamp;
        }
        /*The purpose of calculating the time since the last update is to determine 
        how much time has passed since the interest rates were last adjusted.
        This time duration is then used to calculate the additional interest that should be
         accrued for borrowers and lenders based on their respective interest rates.*/
    }
}
