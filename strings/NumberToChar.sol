// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/// @title NumToCharacter
/// @notice This contract converts a number into its corresponding string representation.
contract NumToCharacter {
    
    /// @notice Converts a number into its corresponding string representation.
    /// @dev This function uses a loop and modulo operator to extract each digit of the number and convert it to its ASCII character representation.
    /// @param _value The number to be converted.
    /// @return The string representation of the input number.
    function convertToString(uint256 _value) public pure returns (string memory) {
        if (_value == 0) {
            return "0";
        }
        
        uint256 temp;
        uint256 digits;
        
        temp = _value;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        
        bytes memory buffer = new bytes(digits);
        temp = _value;
        
        for (uint256 i = digits; i > 0;) {
            buffer[i - 1] = bytes1(uint8(48 + temp % 10));
            temp /= 10;

            unchecked {
                --i;
            }
        }
        
        return string(buffer);
    }
}
