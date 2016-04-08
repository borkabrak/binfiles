#!/usr/bin/env php
<?php

// Load sample $bioData
$bioData = array(
    array(
        'Name' => 'Bilbo',
        'age' => '144',
        'subType' => 'Hobbit',
    ),
    array(
        'Name' => 'Gandalf',
        'age' => '3000',
        'subType' => 'Wizard',
    ),
    array(
        'Name' => 'Gimli',
        'age' => '300',
        'subType' => 'Dwarf',
    ),
    array(
        'Name' => 'Tom Bombadil',
    ),
    array(
        'Name' => 'John Keats',
        'age' => '26',
        'subType' => 'human',
    ),
);

// convertData():
//
//     Apply a list of conversions to each element in a data set, returning the
//     converted data as a new array.
//
//
//     - $data
//          array of associative arrays with keys 'Name' and 'SubType'
//
//     - $conversion
//          array of associative arrays with keys 'pattern' and 'newSubType'
//
// For each element of $data whose 'Name' matches 'pattern', its 'SubType' will
// be changed to the value of 'newSubType'
function convertData($bioData, $conversions) {

    // Iterate through the data elements
    return array_map( function($value) use($conversions) {

        // Apply each conversion
        foreach($conversions as $conversion) {
            // If the Name matches the pattern, change SubType to the new value
            if ( preg_match($conversion['pattern'], $value['Name'])) {
                $value['subType'] = $conversion['newSubType'];
            }
        }

        return $value;

    }, $bioData);
}

print_r(convertData($bioData, array(
    array(
        'pattern' => "/^g/",
        'newSubType' => 'NewGroup'
    )
)));

class TestClass {

    /**
     * constructor thing
     */
    function __construct() {
    }

    /**
     * constructor show
     * @param thang
     * @return thung
     */
    function show() {
    }

}
?>
