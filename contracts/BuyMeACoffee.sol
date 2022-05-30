//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
// deployed to goerli at 0x2003E70a55d260ab352778782A42758AE6cCA1C6

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received.
    Memo[] memos;

    // Address of contract deployer.
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for the contract owner
     * @param _name name of the coffee buyer
     * @param _message nice message from the coffee buyer
    */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "You must send a non-zero amount of ETH");

        // Add the memo to smart contract blockchain storage.
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created.
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev send entire balance stored to the wallet owner
    */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev retrieve memos stored on the blockchain
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
