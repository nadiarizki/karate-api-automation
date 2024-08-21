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
        "name": "Tenali Ramakrishna",
        "gender": "male",
        "email": "tenali.test13@15ce.com",
        "status": "active"
    }
    """
    When method POST
    Then status 201
    And match response.name == 'Tenali Ramakrishna'
    And match response.gender == 'male'
    And match response.email == 'tenali.test13@15ce.com'
    * def id = response.id
    
    # Get user
    Given path 'users/' + id
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.id == id
    And match response.name == 'Tenali Ramakrishna'
    
    # Update user
    Given path 'users/' + id
    And header Authorization = 'Bearer ' + token
    And request
    """
    {
        "name": "Update Tenali Ramakrishna",
        "gender": "female",
        "email": "tenali.test-update@15ce.com",
        "status": "active"
    }
    """
    When method PATCH
    Then status 200
    And match response.name == 'Update Tenali Ramakrishna'
    And match response.gender == 'female'
    
    # Delete user
    Given path 'users/' + id
    And header Authorization = 'Bearer ' + token
    When method DELETE
    Then status 204
