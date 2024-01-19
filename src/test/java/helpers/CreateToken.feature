Feature: Call the login to get the token

Scenario: Get the token
    Given url apiURL
    Given path 'users/login'
    
    # Get variables based on the selected environment from karate-config.js
    And request { "user": { "email": "#(userEmail)", "password": "#(userPassword)"} }
    
    When method Post
    Then status 200
    * def authToken = response.user.token