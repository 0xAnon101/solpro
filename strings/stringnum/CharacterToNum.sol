// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


/// @title CharacterToNum
/// @notice This contract converts a string of characters representing a number into its numerical value.
/// @dev This contract uses ASCII values to calculate the numerical value of the characters.
contract CharacterToNum {

    error NotANumber(uint8 _number);


    /// @notice Parses a string of characters representing a number and returns its numerical value.
    /// @dev This function uses ASCII values to calculate the numerical value of the characters.
    /// @param _value The string of characters representing the number.
    /// @return The numerical value of the input string.
    function parseString(string calldata _value) external pure returns (uint256) {

        uint256 number = 0;
        uint256 lengthOfString = bytes(_value).length;
        uint256 position = lengthOfString - 1;

        for(uint i = 1 ; i <= lengthOfString; ) {
            // since ASCII occupies 1 byte of memory storage
            uint8 _singleDigit = uint8(bytes(_value)[i - 1]);

            if(!(_singleDigit >= 48 && _singleDigit <=57)) {
                revert NotANumber(_singleDigit);
            }
            number += (_singleDigit - 48) *  (10 ** position);

            if(position > 0) {
                --position;
            }

            unchecked {
                ++i;
            }

        }
        return number;
    }
}