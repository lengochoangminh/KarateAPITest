The documentation are in https://github.com/karatelabs/karate

1. Showcase for GET, POST & DELETE methods. To do is refactor them to demo the flow: create > get > delete an article
2. Helper > store the token and use in each feature test. The keyword callonce, parameters for username & password
Environment Variables > mvn test -Dkarate.options="--tags @debug" -Dkarate.env="dev"

## Feature 001 - Get an article & do the assertions
 - Calling the GET request to query an article 
 - Assertions (match & fuzzy match)
 - Schema Validation + Write a JS function timeValidator in Helpers to validate the Schema of the date time fields
 - Conditional Logics

## Feature 002 - Add a new article & Delete
 - Showcase of the keywords: callone & call
 - Karate-config.js: Global Variables, Environment handler, Add a default header of requests
 - Using Faker to generate the data and parse to JSON object

 ## Feature 003 - Sign up a new user
 - Data Driven with Scenario Outline