Feature: User can edit a Spot


Scenario: Edit a Spot 
    Given I am on the Ecospot login page
    When User is created
    And I fill in "Email" with "guest@gmail.com"
    And I fill in "Password" with "password"
    And I press "Log in"
    Then I should see "Signed in successfully."
    Then I should be on the Ecospot home page
    When I press "Add new Spot"
    Then I should be on Create new Spot page
    When I fill in "Name" with "Parco"
    And I fill in "Location" with "Milano"
    When I attach the file "/home/biar/Pictures/Wallpapers/02.jpg" to "Image"
    And I press "Create Spot"
    Then I should be on the Ecospot spot page
    And I should see "Parco"
    And I follow "Edit"
    And I fill in "Location" with "Roma,Italy"
    And I press "Update Spot"
    Then I should be on the Ecospot spot page
    And I should see "Roma,Italy"
