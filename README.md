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

All files will be generated and placed in the `output` folder. **Please make sure you have the correct permissions to write to the folder this README (and all the code) is currently located in.** The processor can be run multiple times without issue; it will simply overwrite the files that are currently there.

## Testing

Run 'bundle exec rspec'.

## Design

### Current Design

The design of this processor was divided and completed in three stages:
1. Parsing the input file.
2. Converting the data into a more meaningful object representation.
3. Generate the HTML files from the object representation.

You can see these three stages represented by the following class:
1. ImageDataProcessor::Parser
2. ImageDataProcessor::ImageFactory
3. ImageDataProcessor::HtmlBuilder

The idea was to keep these three areas fairly modular and separate for maximum flexibility. For example, the ImageFactory doesn't care where the data came from, as long as the data it receives is in an array of hashes. The HtmlBuilder doesn't care where the objects came from as long as they quack like they are supposed to. The parser could instead be a JSON feed or a webpage scraper and the other two module wouldn't need to change.

### Things I'm happy with

The classes are really modular and small. Each class does pretty well to adhere to the Single Responsiblity Principle.

Most of the classes are thoroughly tested without having to resort to weird mocks that test implementation rather than behaviour (an exception to this being the HtmlBuilder class spec).

The design I originally had in my head came together really well, and allowed me to work on each section of that solution (as described above) without having to worry too much about how it would interact.

Converting the data to a PORO means that it is quite flexible for the future if more interesting behaviour needed to be added to the image data.

### Things I'd like to improve

Firstly, I would add some CSS to make the pages look a lot better. It seemed a bit out of the scope of this code challenge and I wasn't sure if I could change the template.

Secondly, I would remove the hard-coding of xml node names in the parser files.  At the moment it is very brittle, if the file doesn't fit the expected format it fails.  It does the job it's supposed to but in order to easily change the format later on it would need to be made more flexible. I have put a TODO task in there to remind me to change it to a YAML file or something that is easily deployed without having to redeploy the whole codebase.

This also goes for the file creation. It needs to be more robust (check that it's not overwriting anything it shouldn't, check for permissions, etc.) and flexible (allow you to define a template, allow you to define an output folder, etc.). At the moment a lot of this is hardcoded.

I'm also unhappy with the naming of the classes/modules that build the HTML to insert. `TitleGenerator`, `NavigationGenerator` and `GalleryGenerator` sound a bit vague, and get extra silly when you call their generate methods, e.g. `TitleGenerator.generate_title`. They also need to be made a bit more uniform in terms of their interfaces.

The bit of meta-programming in the `Image` class is a bit horrid, solely because I don't really like using `instance_variable_get`, it just makes me feel a bit dirty.

The nested loops with a group by in the `build_model_pages` method in the `HtmlBuilder` class need to be removed or at the very least optimized somehow, as it does in the `generate_menu_item_of_type` in the `NavigationGenerator` class.

I'd like to fix up the `HtmlBuilder` class spec so it doesn't rely so much on mocks, or scrap it totally since its pretty much covered by the root level integration test.

## Licence

See LICENCE.txt.

## Contributing

This project doesn't currently accept contributions.
