// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/// @title NumToCharacter
/// @notice This contract converts a number into its corresponding string representation.
contract CharToNumber {


    /// @notice Parses a string of characters representing a number and returns its numerical value.
    /// @dev This function uses ASCII values to calculate the numerical value of the characters.
    /// @param _value The string of characters representing the number.
    /// @return The numerical value of the input string.
   function parseString(string memory _value) external pure returns (uint256) {
    uint256 numberis;

    assembly {
            let len := mload(_value) // loads the _value in memory but the start 32 bytes are length of it 
            let _valueloc := add(_value, 0x20) // next we add 0x20 which is basically 16*2 = 32 bytes after 
            
            // Iterate over each character in the string
            for {let end := add(_valueloc, len)} lt(_valueloc, end) { _valueloc := add(_valueloc, 1)} {

                let _singleDigit := mload(_valueloc)

                // load the string value from p location
                // then take the first byte value of _value
                // then it subtract it from 0x30 [16*3=> 48]
                // 48 to 57 location converts to range 0-9
                // This way we get the decimal representation of firsrt digit
                let digit := sub(byte(0, _singleDigit), 0x30) 


                // revert it string not between ascii of 0-9
                // necessary such that it doesn't accept any alphabets or symbols
                if or(lt(digit, 0), gt(digit, 9)) {
                    revert(0, 0) // Revert if a non-numeric character is encountered
                }
                
                // Multiply the result by 10 and add the digit
                // "789" , we now have 7 here. 
                // (0*10) + 7 => 7
                // (7*10) + 8 => 78
                // (78*10) + 9 => 789
                numberis := add(mul(numberis, 10), digit)
            }
        }
        return numberis; 
    }
}