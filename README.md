# Redbubble Code Challenge

## Aim

Create a batch processor that takes the provided input file (docs/works.xml) and produces a single HTML file based on the output template given (docs/output-template.html) for each camera make and model, as well as an index.

## Environment

* Ruby 2.1.5
* Mac OSX Yosemite (10.10.1)

## Installation

`cd` into the root of this directory.

Run `bundle install`.

## Usage

To generate the html pages run `ruby run.rb *<filename>*` where *<filename>* is the path to the input xml file.

All files will be generated and placed in the `output` folder. **Please make sure you have the correct permissions to write to the folder this README (and all the code) is currently located in.**

## Testing

Run 'bundle exec rspec'.

## Design


## Licence

See LICENCE.txt.

## Contributing

This project doesn't currently accept contributions.
