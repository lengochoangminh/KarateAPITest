# Scenario - Do like to Article - POST - https://api.realworld.io/api/articles/New-articles-test5-1365/favorite 
# Response Body
# {
#     "article": {
#         "id": 952,
#         "slug": "New-articles-test5-1365",
#         "title": "New articles test5",
#         "description": "testing",
#         "body": "test create a article ",
#         "createdAt": "2024-01-05T07:53:31.635Z",
#         "updatedAt": "2024-01-05T07:53:31.635Z",
#         "authorId": 1365,
#         "tagList": [],
#         "author": {
#             "username": "Karate1",
#             "bio": null,
#             "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
#             "following": false
#         },
#         "favoritedBy": [
#             {
#                 "id": 1365,
#                 "email": "karate@test.com",
#                 "username": "Karate1",
#                 "password": "$2a$10$dhG/WXWY232nC5j1FEBjjuPTYC4uVkD.zv.lGl7oMuRwoO1MJ1sAi",
#                 "image": "https://api.realworld.io/images/smiley-cyrus.jpeg",
#                 "bio": null,
#                 "demo": false
#             }
#         ],
#         "favorited": true,
#         "favoritesCount": 1
#     }
# }
Feature: Add likes

Background: Define URL
  * url apiURL

Scenario: Add likes
    Given path 'articles', slug, 'favorite'
    And request {}
    When method Post
    Then status 200
    * def likesCount = response.article.favoritesCount