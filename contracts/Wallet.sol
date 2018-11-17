pragma solidity ^0.4.25;

import "browser/Channel.sol";

contract Wallet{
 
    struct channelUser {
        address wallet; // person delegated to
        uint value;
        mapping (address => Channel0) channelIndex;
    }

    struct Channel0 {
        Channel channel_ref;
        address _from;   // local address
        address _to;
        uint startDate;
	    uint channelTimeout;
	    uint value; //accumulated value to be sent
    }

    address public moderator;
    mapping (address => channelUser) User;
 
    function Wallet() public {  //uint8 _numProposals
        moderator = msg.sender;
        User[moderator].wallet = msg.sender;
        User[moderator].value = 100;
    }
    
    function initiateUser() public{
        channelUser storage sendUser=User[msg.sender];
        sendUser.value=10;   //maybe initiate is not useful; exist when called
        
    }
//    function giveRightToVote(address toVoter) public {
//       if (msg.sender != chairperson || voters[toVoter].voted) return;
//        voters[toVoter].weight = 1;
//    }
    function openChannel(address _with,uint _channelTimeout){
       channelUser storage openUser = User[msg.sender];   //here it requires initiateUser (on both sides?)
        Channel0 storage newChannel = openUser.channelIndex[_with];
        newChannel._from=msg.sender;
        newChannel._to=_with;
        newChannel.startDate=now;
        newChannel.channelTimeout=_channelTimeout;
        newChannel.value=0;   
    //function setFeed(InfoFeed addr) public { feed = addr; }
    //function callFeed() public { feed.info.value(10).gas(800)(); }
        
    }
    
}
}