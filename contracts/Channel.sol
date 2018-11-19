pragma solidity ^0.4.24;

contract Channel {
	string public name;
    address public from;   // local address
    address[] public to;
    uint startDate;
	uint channelTimeout;
	uint value; //accumulated value to be sent

	mapping (bytes32 => address) signatures;
	
	function getName() public returns(string){
			return name;
	}
	
	function Channel() payable { 
		//
		name='undef';
		to[0] = msg.sender;
		from = msg.sender;
		startDate = now;
		channelTimeout = now;
		value=0;
	}

	function openChannel(string _name, address _to, uint _timeout) payable { 
		//address to, uint timeout
		name=_name;
		to[0] = _to;
		from = msg.sender;
		startDate = now;
		channelTimeout = _timeout;   //remember to verify
		value=0;
	}

	function CloseChannel(bytes32 h, uint8 v, bytes32 r, bytes32 s, uint value){

		address signer;
		bytes32 proof;

		// get signer from signature
		signer = ecrecover(h, v, r, s);

		// signature is invalid, throw
		if (signer != from && signer != to[0]) throw;

		proof = sha3(this, value);

		// signature is valid but doesn't match the data provided
		if (proof != h) throw;

		if (signatures[proof] == 0)
			signatures[proof] = signer;
		else if (signatures[proof] != signer){
			// channel completed, both signatures provided
			//if (!_to.send(value)) throw; Remember to send value !!!
			selfdestruct(from);
		}

	}

	function ChannelTimeout(){
		if (startDate + channelTimeout > now)
			throw;

		selfdestruct(from);
	}

}