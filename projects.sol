// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract projects{

    struct Project {
        string titre;
        string description;
        uint256 id;
        address owner;
    }
        Project  [] public  projects ;

        mapping (uint256=>address[]) public donatorPerProject;
        mapping (address=>uint256) donatorAndAmount;
        mapping (uint256=>Project) projectIdandProject;

        address [] public  donators ;
        uint public count = 0;

        constructor(){

        }

        function incrementCount() public returns (uint256) {
	    count++; 
	    return uint256(count);
    }


    function create(string memory _titre,string memory _description) public {
        Project memory project;
        project.titre = _titre;
        uint256 _id=incrementCount();
        project.id=_id;
        project.owner=msg.sender;
        projects.push(project);
    }

    function donate(uint256 _id) public payable {//id hua contract id
        require(donatorAndAmount[msg.sender]==0,"You alrady donated") ;
            donators.push(msg.sender);//arr dyal all donators
            donatorAndAmount[msg.sender]+=msg.value;
            donatorPerProject[_id].push(msg.sender);//id w 7dah array d adresses l donators
            payable (projectIdandProject[_id].owner).transfer(msg.value);
        
       
    }
}