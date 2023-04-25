// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract urgig{
    struct User{
        uint index;
        string name;
        address uAddress;
        string uType;
        uint projectsWorked;
        string status;
        string[] categories;
        uint[] uGigs;
    }
    User[] users;

    address payable owner;

    struct Gig {
        uint index;
        address gigOwner;
        uint timestamp;
        uint payment;
        string[] keywords;
        address[] appliedWorkers;
        address gigWorker;
        string status;
    }
    Gig[] gigs;

    constructor() {
        owner = payable(msg.sender);
    }

    function addUser(string memory _name, string memory _uType, string[] memory _categories) public{
        uint[] memory _uGigs;
        users.push(User({index: users.length-1, name: _name, uAddress: msg.sender, projectsWorked: 0, status: "free",  uType: _uType, categories: _categories, uGigs: _uGigs}));
    }

    function getUserIndex() public view returns (uint256){
        for(uint i=0; i<users.length; i++){
            if(users[i].uAddress == msg.sender){
                return i;
                break;
            }
        }
    }

    function addGig(uint _payment, string[] memory _keywords, address[] memory _appliedWorkers) public payable {
        require(msg.value >= 0, "please pay more if you want to add gig");
        address _gigWorker;
        gigs.push(Gig({index: gigs.length-1, gigOwner: msg.sender, timestamp: block.timestamp, payment: _payment, keywords: _keywords, appliedWorkers: _appliedWorkers, gigWorker: _gigWorker, status: "open"}));
    }

    function applyGig(uint _index) public {
        gigs[_index].appliedWorkers.push(msg.sender);
    }

    function selectWorker(uint _uindex, uint _gindex) public {
        require(users[_uindex].uAddress == msg.sender, "You are not owner of this gig");
        gigs[_gindex].gigWorker = users[_uindex].uAddress;
        users[getUserIndex()].uGigs.push(_gindex);
    }

    function approvePayment(uint _index) public {
        require(users[_index].uAddress == msg.sender, "You are not owner of this gig");
        (bool callSuccess, ) = payable(gigs[_index].gigWorker).call{value: gigs[_index].payment}("");
    }

}