/// @title Token Register Contract
/// @author Kongliang Zhong - <<a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="f59e9a9b92999c949b92b5999a9a85879c9b92db9a8792">[email&#160;protected]</a>>,
/// @author Daniel Wang - <<a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="87e3e6e9eee2ebc7ebe8e8f7f5eee9e0a9e8f5e0">[email&#160;protected]</a>>.
library Bytes32Lib {

    function xorReduce(
        bytes32[]   arr,
        uint        len
        )
        public
        constant
        returns (bytes32 res) {

        res = arr[0];
        for (uint i = 1; i < len; i++) {
            res = _xor(res, arr[i]);
        }
    }

    function _xor(
        bytes32 bs1,
        bytes32 bs2
        )
        public
        constant
        returns (bytes32 res) {

        bytes memory temp = new bytes(32);
        for (uint i = 0; i < 32; i++) {
            temp[i] = bs1[i] ^ bs2[i];
        }
        string memory str = string(temp);
        assembly {
            res := mload(add(str, 32))
        }
    }
}