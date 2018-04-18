// String Utils v0.1

/// @title String Utils - String utility functions
/// @author Piper Merriam - <<a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="5d2d342d382f30382f2f343c301d3a303c3431733e3230">[email&#160;protected]</a>>
library StringLib {
    /// @dev Converts an unsigned integert to its string representation.
    /// @param v The number to be converted.
    function uintToBytes(uint v) constant returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        }
        else {
            while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }

    /// @dev Converts a numeric string to it's unsigned integer representation.
    /// @param v The string to be converted.
    function bytesToUInt(bytes32 v) constant returns (uint ret) {
        if (v == 0x0) {
            throw;
        }

        uint digit;

        for (uint i = 0; i < 32; i++) {
            digit = uint((uint(v) / (2 ** (8 * (31 - i)))) & 0xff);
            if (digit == 0) {
                break;
            }
            else if (digit < 48 || digit > 57) {
                throw;
            }
            ret *= 10;
            ret += (digit - 48);
        }
        return ret;
    }
}


/// @title String Utils - String utility functions
/// @author Piper Merriam - <<a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="a3d3cad3c6d1cec6d1d1cac2cee3c4cec2cacf8dc0ccce">[email&#160;protected]</a>>
library StringUtils {
    /// @dev Converts an unsigned integert to its string representation.
    /// @param v The number to be converted.
    function uintToBytes(uint v) constant returns (bytes32 ret) {
            return StringLib.uintToBytes(v);
    }

    /// @dev Converts a numeric string to it's unsigned integer representation.
    /// @param v The string to be converted.
    function bytesToUInt(bytes32 v) constant returns (uint ret) {
            return StringLib.bytesToUInt(v);
    }
}