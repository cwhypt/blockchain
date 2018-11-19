pragma solidity ^0.4.24;

contract Channel {
	string public name;
    address public from;   // local address
    address[] public to;
    uint startDate;
	uint channelTimeout;
	uint value; //accumulated value to be sent

	mapping (bytes32 => address) signatures;
	
	function Channel() payable { 
		//address to, uint timeout
		name='undef';
		to = msg.sender;
		from = msg.sender;
		startDate = now;
		channelTimeout = now;
		value=0;
	}

	function CloseChannel(bytes32 h, uint8 v, bytes32 r, bytes32 s, uint value){

		address signer;
		bytes32 proof;

		// get signer from signature
		signer = ecrecover(h, v, r, s);

		// signature is invalid, throw
		if (signer != from && signer != to) throw;

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