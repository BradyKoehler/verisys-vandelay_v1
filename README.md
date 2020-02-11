# Introduction

Thank you for your interest in Verisys. We have a great group of engineers that love solving problems and coming up with cool solutions to helping protect our families.

The purpose of the challenge is to help us evaluate you as an engineer. We aren’t looking for the prettiest UI or the most verbose code. We value engineers that:

- Write clean, testable, and maintainable code
- Have good architectural skills
- Follow best practices
- Have fun

As this is a personal challenge we encourage you to use the internet to its fullest to help you solve this problem - with just a few limitations that wouldn’t be present in the real world:

- Don’t ask your friends or neighbors for help
- Don’t reuse someone else’s solution

This is _**YOUR**_ chance to shine. Be honest and do your best.

We don’t want you to spend more than 2-3 hours on this project (you do have a life outside of coding?). It isn’t anticipated that you will finish the whole thing. Get as far as you can and provide guidance on what you would do next.

# Submission

You can either put your solution up on GitHub / BitBucket in your own repository or you can zip it all up and send it to us via email. You will need to include:

- Source code
- JSON Output from the 3 samples that you ingest
- Readme - that includes:
  - Instructions on how to build and run your solution
  - Overview of the process you used and the technologies you used
  - Any challenges you faced
  - Questions or assumptions you made
  - Next steps to finish the challenge
  - Feedback on the challenge itself

# Challenge

Vandelay Industries ( https://www.youtube.com/watch?v=OefQwYN6vbM )wants to take all of their regional offices' jumbled contact lists and clean them up on an office by office basis. Each office will submit a CSV file to your application and you will clean it up and return a well-structured JSON file to them that they can then consume in their individual office applications. We have provided 3 such CSV samples for you to process (sample10.csv, sample50.csv, sample100k.csv).

# Challenge Steps

Here are a few checkpoints to guide your development. Please do them in the order specified:

1. Have a command line interface to process the CSV file and return a well-structured (rational object structure) JSON file. (Not just a straight dump of the CSV - note that you will need to merge records later on - use this information to help you decide on your JSON structure)
1. Enhance the process to clean all of the phone numbers to have the format of (###) ###-####
1. Enhance the process to validate license numbers.
   - License numbers MUST have 10 digits and cannot be blank
   - The 10th digit is a “check digit” - This means that you should sum each of the 9 prior digits and then perform a modulus 10 operation on the sum. The result is the 10th digit.
   - For example 1000545443: 3 is the check digit because 1+0+0+0+5+4+5+4+4=23. And 23 modulo 10 = 3
   - If a license number fails validation the whole record should be removed
1. Report the records that are removed
1. Create a simple UI for the Vandelay employees:
   - They should be able to upload the file from their browser
   - View the results in the browser
   - Be able to download the JSON
   - View the records that are removed
   - Download the records that are removed
1. Combine Duplicate records
   - A duplicate is two records with the same license number
   - When you combine the records, the record with the latest `last update date` is the master and all of the phones and addresses from the other record are **appended** to the master record.
     - For example two records have the same license number (1000545443) but one has the name of George Costanza with an update date of 10-JAN-17 and the other record has the name of Elaine Benes with an update date of 4-JUL-19. Elaine’s record is the most recent. Thus, the resulting record will be named Elaine Benes and all of the addresses and phones from George Costanza will be appended to Elaine’s record. (We know it may seem strange, but just humor us)
     - Report the records that were merged

If you get the above done feel free to do more, or relax in cool smugness. Some possible extensions are:

- More test cases (you did write test cases along the way - right?)
- Create a REACT user interface
- List the files that were processed and see historical stats
- Be able to download the original CSV file as well as the JSON file
- Create a full docker image and a docker-compose.yml file so that all we have to do to run your code is `docker-compose up` (Definite bonus points for this)
- etc.
