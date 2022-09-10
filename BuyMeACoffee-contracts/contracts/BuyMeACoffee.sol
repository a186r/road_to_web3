//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint timestamp;
        string name;
        string message;
    }

    // for withdraw
    address payable owner;

    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee for free!");

        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}
