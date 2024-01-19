# Scenario 001 - GET - https://api.realworld.io/api/tags
    # Response Body
    #   {
    #     "tags": [
    #         "enim",
    #         "facilis",
    #         "occaecati"
    #     ]
    #   }

# Scenarion 002 - GET with Params - https://api.realworld.io/api/articles?limit=10&offset=0
# Response Body 
#     { "articles": [
#       {
#         "slug": "Ill-quantify-the-redundant-TCP-bus-that-should-hard-drive-the-ADP-bandwidth!-553",
#         "title": "Ill quantify the redundant TCP bus, that should hard drive the ADP bandwidth!",
#         "description": "Aut facilis qui. Cupiditate sit ratione eum sunt rerum impedit. Qui suscipit debitis et et voluptates voluptatem voluptatibus. Quas voluptatum quae corporis corporis possimus.",
#         "body": "Quis nesciunt ut est eos.\\nQui reiciendis doloribus.\\nEst quidem ullam reprehenderit.\\nEst omnis eligendi quis quis quo eum officiis asperiores quis. Et sed dicta eveniet accusamus consequatur.\\nUllam voluptas consequatur aut eos ducimus.\\nId officia est ut dicta provident beatae ipsa. Pariatur quo neque est perspiciatis non illo rerum expedita minima.\\nEt commodi voluptas eos ex.\\nUnde velit delectus deleniti deleniti non in sit.\\nAliquid voluptatem magni. Iusto laborum aperiam neque delectus consequuntur provident est maiores explicabo. Est est sed itaque necessitatibus vitae officiis.\\nIusto dolores sint eveniet quasi dolore quo laborum esse laboriosam.\\nModi similique aut voluptates animi aut dicta dolorum.\\nSint explicabo autem quidem et.\\nNeque aspernatur assumenda fugit provident. Et fuga repellendus magnam dignissimos eius aspernatur rerum. Dolorum eius dignissimos et magnam voluptate aut voluptatem natus.\\nAut sint est eum molestiae consequatur officia omnis.\\nQuae et quam odit voluptatum itaque ducimus magni dolores ab.\\nDolorum sed iure voluptatem et reiciendis. Eveniet sit ipsa officiis laborum.\\nIn vel est omnis sed impedit quod magni.\\nDignissimos quis illum qui atque aut ut quasi sequi. Eveniet sit ipsa officiis laborum.\\nIn vel est omnis sed impedit quod magni.\\nDignissimos quis illum qui atque aut ut quasi sequi. Sapiente vitae culpa ut voluptatem incidunt excepturi voluptates exercitationem.\\nSed doloribus alias consectetur omnis occaecati ad placeat labore.\\nVoluptate consequatur expedita nemo recusandae sint assumenda.\\nQui vel totam quia fugit saepe suscipit autem quasi qui.\\nEt eum vel ut delectus ut nesciunt animi.",
#         "tagList": [
#             "sit",
#             "reiciendis",
#             "consequuntur",
#             "nihil"
#         ],
#         "createdAt": "2024-01-04T00:52:58.601Z",
#         "updatedAt": "2024-01-04T00:52:58.601Z",
#         "favorited": false,
#         "favoritesCount": 62,
#         "author": {
#             "username": "Maksim Esteban",
#             "bio": null,
#             "image": "https://api.realworld.io/images/demo-avatar.png",
#             "following": false
#         }
#       }, 
#       {}], "articlesCount" : 251}

Feature: Get an article & do the assertions 

  Background: Define URL
    Given url apiURL

  Scenario: 001 - Get an article
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['est', 'enim']
    And match response.tags !contains 'car'
    And match response.tags contains any ['est', 'enim']
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: 002- GET an article with Params - https://api.realworld.io/api/articles?limit=10&offset=0
    * def timeValidator = read('classpath:helpers/timeValidator.js')

    Given params { limit: 10, offset:0}
    Given url 'https://api.realworld.io/api/'
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    # And match response.articlesCount == 261
    # And match response == {"articles" : "#array", "articlesCount": 261}
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 1
    
    # .. to get the sub level in JSON object
    And match response..bio contains null
    And match each response..following == '#boolean'
    
    # schema validation
    And match each response.articles == 
    """
      {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """

  Scenario: 003 - Conditional Logics - Like the article if the favoritesCount = 0
    Given params { limit: 10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount 
    * def article = response.articles[0]

    # * if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount
    
    Given params { limit: 10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    # TODO - Match is Not stable and will fix later
    # And match response.articles[0].favoritesCount == result

    Scenario: 004 - Retry call
      * configure retry = {count: 10, interval : 5000}

      Given params { limit: 10, offset:0}
      Given path 'articles'
      And retry until response.articles[0].favoritesCount == 1
      When method Get
      Then status 200

    # TODO - Not stable and will fix later
    # Scenario: 005 - Sleep call
    #   * def sleep = function(pause) { java.lang.Thread.sleep(pause)}

    #   Given params { limit: 10, offset:0}
    #   Given path 'articles'
    #   When method Get
    #   * eval sleep(2000)
    #   Then status 200