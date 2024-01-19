# curl --location 'https://api.realworld.io/api/users' \
# --header 'Content-Type: application/json' \
# --data-raw '{
#     "user": {
#         "email": "karate456@test.com",
#         "password": "karate456",
#         "username": "karate456"
#     }
# }'

# Response status 201
# {
#     "user": {
#         "id": 3753,
#         "email": "karate456@test.com",
#         "username": "karate456",
#         "bio": null,
#         "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
#         "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjozNzUzfSwiaWF0IjoxNzA1MjQwMDMzLCJleHAiOjE3MTA0MjQwMzN9.XE3948D4owYI22IWRtmHSk8W6dAKcSUg40MHj7EmiW4"
#     }
# }

Feature: Sign up a new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()

    # Given url apiURL or * url apiURL
    * url apiURL
  
Scenario: Sign up a new user    
    Given path 'users'
    And request 
    """
    {
        "user": {
            "email": #(randomEmail),
            "password": "karate123",
            "username": #(randomUsername)
        }
    }
    """
    When method Post
    Then status 201

Scenario Outline: Validate sign up error messages  
    Given path 'users'
    And request 
    """
    {
        "user": {
            "email": "#<email>",
            "password": "#<password>",
            "username": "#<username>"
        }
    }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
    | email             | password  | username            | errorResponse                                           |
    | #(randomEmail)    | karate123 | karateUser123       | {"errors": {"username": ["has already been taken"]}}    |
    | karate@test.com   | karate123 | #(randomUsername)   | {"errors": {"email": ["has already been taken"]}}       |