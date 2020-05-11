# T_NR

DataStage assets to perform different levels of table comparison

## Installation

Just deploy the isx file and configure jdbc drivers if necessary.


## Usage

All assets are deployed in the T_NR folder.

1- Edit the ParameterSet to declare all databases accordingly

2- Either run the jobs individually or from the sequence

 Each job takes 2 arguments: 
 * the table to compare
 * the reference to the ParameterSet

## Limitations

This is not intendend to be performant. It is more a proof of concept.

LOBs and float are not handled well so they have to be dropped or converted (see job documentation for more information)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)