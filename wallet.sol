pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    function sendValueWithoutFee(address dest, uint128 amount) public pure checkOwnerAndAccept {
        dest.transfer(amount, true, 0);
    }

    function sendValueWithFee(address dest, uint128 amount) public pure checkOwnerAndAccept {
        dest.transfer(amount, true, 1);
    }

    function sendAllMoneyAndDestroy(address dest) public pure checkOwnerAndAccept {
        dest.transfer(1, true, 160);
    }
}