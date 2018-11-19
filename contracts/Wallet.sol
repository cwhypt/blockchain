pragma solidity ^0.4.24;

import "./Channel.sol";

contract Wallet{
 
    address public moderator;
    mapping (address => channelUser) User;
 
    struct channelUser {
        address wallet; // person delegated to
        uint value;
        mapping (string => Channel) channels;
    }


    function Wallet() public {  //uint8 _numProposals
        moderator = msg.sender;
        User[moderator].wallet = msg.sender;
        User[moderator].value = 100;
    }
    
	function initiateUser() public view {
        channelUser storage sendUser=User[msg.sender];
        sendUser.value=10;   //maybe initiate is not useful; exist when called
        
    }
	
	
	
	
	function getValue(address _from) public view returns(uint) {  
        return User[_from].value;
    }
	
    function getChannel(string _nameref) public view returns(string) {  
		channelUser user=User[msg.sender];
		Channel ch0=user.channels[_nameref];
        return ch0.name;
    }

//    function giveRightToVote(address toVoter) public {
//       if (msg.sender != chairperson || voters[toVoter].voted) return;
//        voters[toVoter].weight = 1;
//    }
	
	function send(address _to,uint _value) public {
		User[msg.sender].value-=_value;
		User[_to].value+=_value;
	}
    function openChannel(address _with,uint _channelTimeout,string _name) payable {
       channelUser openUser = User[msg.sender];   //here it requires initiateUser (on both sides?)
        Channel newChannel = openUser.channels[_name];
		newChannel.name=_name;
        newChannel.from=msg.sender;
        newChannel.to=_with;
        newChannel.startDate=now;
        newChannel.channelTimeout=_channelTimeout;
        newChannel.value=123;   
    //function setFeed(InfoFeed addr) public { feed = addr; }
    //function callFeed() public { feed.info.value(10).gas(800)(); }
        
    }
    
}