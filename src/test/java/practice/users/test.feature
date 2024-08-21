Feature: Sea lab exam

Background:
    * url 'https://gorest.co.in/public/v2/'
    * def token = '745c09bfae4b59be277127c6293025735cf3aba5e2870fcdbef4bfd3b8fb9a4a'

Scenario: Create, Get, Update, and Delete User
    # Create user
    Given path 'users'
    And header Authorization = 'Bearer ' + token
    And request
    """
    {
        "name": "Nadia Rizki",
        "gender": "male",
        "email": "nadia@makankor.net",
        "status": "active"
    }
    """
    When method POST
    Then status 201
    And match response.name == 'Nadia Rizki'
    And match response.gender == 'female'
    And match response.email == 'nadia@makankor.net'
    * def id = response.id
    
    # Get user
    Given path 'users/' + id
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match id == id
    And match response.name == 'Nadia Rizki'
    And match response == '#array'
    Then match each response[*] ==
    """
    {
        "id": "#string",
        "name": "#string",
        "gender": "#string",
        "email": "#string",
        "status": "#string"
    }
    """
    
    # Update user
    Given path 'users/' + id
    And header Authorization = 'Bearer ' + token
    And request
    """
    {
        "name": "Update Nadia Rizki",
        "gender": "female",
        "email": "nadia@makankor.net",
        "status": "active"
    }
    """
    When method PATCH
    Then status 200
    And match response.name == 'Update Nadia Rizki'
    And match response.gender == 'female'
    
    # Delete user
    Given path 'users/' + id
    And header Authorization = 'Bearer ' + token
    When method DELETE
    Then status 204
