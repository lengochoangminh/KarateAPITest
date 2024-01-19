# Step 1 - Call POST Login request to get the token
  # curl --location 'https://api.realworld.io/api/users/login' \
  # --header 'Content-Type: application/json' \
  # --data-raw '{
  #     "user": {
  #         "email": "karate@test.com",
  #         "password": "karate123"
  #     }
  # }'
# Response Body
  # {
  #     "user": {
  #         "email": "karate@test.com",
  #         "username": "Karate1",
  #         "bio": null,
  #         "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
  #         "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxMzY1fSwiaWF0IjoxNzA1MDY3OTY4LCJleHAiOjE3MTAyNTE5Njh9.uRGKNk2kMaxwpbbtHGAnLZBgeDgAiUZwWDmFVwW3OWU"
  #     }
  # }

# Step 2 - Use the token to call the POST Request of creating a new article
  # curl --location 'https://api.realworld.io/api/articles' \
  # --header 'Authorization: Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxMzY1fSwiaWF0IjoxNzA1MDY3OTY4LCJleHAiOjE3MTAyNTE5Njh9.uRGKNk2kMaxwpbbtHGAnLZBgeDgAiUZwWDmFVwW3OWU' \
  # --header 'Content-Type: application/json' \
  # --data '{
  #     "article": {
  #         "taglist": [],
  #         "title": "karate-test-1",
  #         "description": "test abc",
  #         "body": "body"
  #     }
  # }'
# Response Body
  # {
  #     "article": {
  #         "slug": "karate-test-1-1365",
  #         "title": "karate-test-1",
  #         "description": "test abc",
  #         "body": "body",
  #         "tagList": [],
  #         "createdAt": "2024-01-12T14:06:18.204Z",
  #         "updatedAt": "2024-01-12T14:06:18.204Z",
  #         "favorited": false,
  #         "favoritesCount": 0,
  #         "author": {
  #             "username": "Karate1",
  #             "bio": null,
  #             "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
  #             "following": false
  #         }
  #     }
  # }

Feature: Showcases - POST & DELETE request

Background: Define URL
  # Global environment variable apiURL from from karate-config.js
  Given url apiURL
      
  # Using Faker to generate the data and parse to JSON object 
  * def articleRequestBody = read('classpath:examples/json/newArticleRequest.json')
  * def dataGenerator = Java.type('helpers.DataGenerator')
  * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
  * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
  * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

Scenario: Create a new article and Delete
    # Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 201
    * def articleId = response.article.slug
    And match response.article.title == articleRequestBody.article.title
    
    Given path 'articles', articleId
    When method Delete
    Then status 204