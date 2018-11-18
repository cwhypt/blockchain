pragma solidity ^0.4.24;

import "./Channel.sol";

contract Wallet{
 
    address public moderator;
    mapping (address => channelUser) User;
 
    struct channelUser {
        address wallet; // person delegated to
        uint value;
        mapping (string => Channel0) channels;
    }

	
    struct Channel0 {
        Channel channel_ref;
        address _from;   // local address
        address _to;
        uint startDate;
	    uint channelTimeout;
	    uint value; //accumulated value to be sent
    }

    function Wallet() public {  //uint8 _numProposals
        moderator = msg.sender;
        User[moderator].wallet = msg.sender;
        User[moderator].value = 100;
    }
    
	function initiateUser() public{
        channelUser storage sendUser=User[msg.sender];
        sendUser.value=10;   //maybe initiate is not useful; exist when called
        
    }
	
	
	
	
	function getValue(address _from) public view returns(uint) {  
        return User[_from].value;
    }
	
    function getChannel(string _name) public view returns(address) {  
		channelUser user=User[msg.sender];
        return user.channels[_name];
    }

//    function giveRightToVote(address toVoter) public {
//       if (msg.sender != chairperson || voters[toVoter].voted) return;
//        voters[toVoter].weight = 1;
//    }
    function openChannel(address _with,uint _channelTimeout){
       channelUser storage openUser = User[msg.sender];   //here it requires initiateUser (on both sides?)
        Channel0 storage newChannel = openUser.channels[_with];
        newChannel._from=msg.sender;
        newChannel._to=_with;
        newChannel.startDate=now;
        newChannel.channelTimeout=_channelTimeout;
        newChannel.value=0;   
    //function setFeed(InfoFeed addr) public { feed = addr; }
    //function callFeed() public { feed.info.value(10).gas(800)(); }
        
    }
    
}