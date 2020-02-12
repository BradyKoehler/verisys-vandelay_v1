# Intoduction

This project was built as part of the interview process for Verisys. The original instructions and guidelines for the endeavor can be found in the[INSTRUCTIONS.md] file, but the general goal was to first create a CLI to allow a user to generate a structured and validated JSON file of contacts from a CSV file and then develop a web-based interface for accomplishing the same task.

# Building and Running the Solution

The main project folder where this document is found contains the sample CSV files provided and their JSON-formatted counterparts as well as the root folder for the `contacts_parser` gem. To get started, you'll first want to clone this repository using:
```
$ git clone https://github.com/BradyKoehler/verisys-vandelay_v1.git
```
Next, open the project folder in your terminal and navigate to the `contacts_parser` directory and run:
```
$ bundle install
```
To install the gem's dependencies. You may need to update `bundler` to do this, as the gem was developed using v2.1.2. It was also developed on Ruby 2.7.0 and also tested on 2.6.4, but I'm not sure how it will work on other versions.

After the dependencies are installed, you should be able to run:
```
$ rake install
```
To install the gem locally. This will give you access to the `contacts_parser` command, which provides both the CLI application and the ability to start the server for the web interface. Running:
```
$ contacts_parser -h
```
Will give you a list of command line options for the gem. In its simplest form, it only needs to be passed a filename pointing to a CSV file. It will parse that file, and write the results to a file in the same directory and with the same name as the original file but appended with ".json". I recommend also passing the `-v` (or `--verbose`) flag, especially if parsing the [sample100k.csv] file, to see a bit of what's going on instead of just waiting for the process to finish.

To access the web interface, run:
```
$ contacts_parser -s
```
This will bind the web server to ( localhost:4567 ) by default, though this can be changed using the `-b` (`--bind`) and `-p` (`--port`) flags. Once you've accessed the web page, you'll be able to submit a CSV file and then browse and download the results. The results are currently limited to showing 100 entries in the browser to keep it from crashing, but the downloadable JSON files contain the full results.

# Overview of Development

For the most part I followed the Challenge Steps sequentially (see [INSTRUCTIONS.md]). I started out by running `bundle gem contacts_parser` to get the skeleton of the gem in place. The first four steps were done solely in Ruby, and the first step took the longest by far as I figured out the best way to structure the program. Reading CSV files and writing JSON to files was fairly trivial, as Ruby has standard libraries for working with both of those. Steps 2-4 were straightforward, and I didn't run into any problems there. With the phone numbers, I made the assumption based on the instructions that the country codes aren't relevant. Another key assumption I made was that the columns would be the same in each input file.

Once it was time to start working on the web interface, I decided to use the Sinatra framework. It's lightweight and integrated nicely with the existing gem. I did have a few issues with the Sinatra gem command-line arguments overriding the ones I had built into my gem, but I was able to solve this by deferring the loading of the file containing the Sinatra app until the server needed to be started. I fleshed out the command-line options for the program both to allow better control over the CLI as well as to allow the basic host/port settings of the Sinatra server to be configured.

Once Sinatra was integrated, completing Step 5 was simple: a landing page with a form accepting a file upload and a target page where the processed data was displayed to the user. The structure of the gem made it easy to use the methods from Sinatra with little to no modifications. Completing Step 6, Combining Duplicate Records, was also fairly simple. The most challenging part was working on the best way to pass data around. I did run into an error while evaluating the "Last Update" dates in the records, as one sample ([sample10.csv]) used a different date format than the others.

# Next Steps

Obviously a lot more could have been done with the project. Some of the basic potential improvements include:
- [ ] Better testing - while I tried to write a few simple tests, I could have been much more thorough.
- [ ] Better validation - aside from the data validations specified in the challenge instructions, the project would be improved by validating the input and output files themselves, including:
  - Checking that the file actually exists.
  - Verifying the file format.
  - Checking if the output file already exists and, if so,  asking for an overwrite confirmation.
- [ ] Better UI - The web interface and backend is very simple and there are a lot of features which could be added, including:
  - Storing results in a database for later access.
  - Pagination of results so that access to all the data can be provided through the browser without causing it to crash.
  - Ability to search/sort/filter the data in the tables
  - Use AJAX when uploading files. This would allow the status to be shown (i.e. uploading, parsing, validating, etc.) and a link displayed once the data is ready, instead of waiting for the page to load.
- [ ] Column mapping - currently the gem depends on the assumption that the column order will stay the same for all uploaded CSV files. However, a more intuitive system that could parse the column headers and match them to the relevant attributes and/or let the users match them as needed would be more robust.
- [ ] Data management - I'm realizing now that when the web server is used, the uploaded and created files aren't ever deleted, even though uploads aren't tracked in a database anywhere. That would need to be fixed.

# Thoughts on the Challenge

The project was fun. It was straightforward but still required some thought about how to accomplish each step of the challenge. It's definitely something that I could spend more time, and I learned a few new things while doing it that made it all the more fun (I'd never used the `optparse` or `sinatra` gems before).