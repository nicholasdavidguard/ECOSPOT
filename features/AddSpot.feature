Feature: User can add a Spot


Scenario: Add a Spot 
    Given I am on the Ecospot login page
    When User is created
    And I fill in "Email" with "guest@gmail.com"
    And I fill in "Password" with "password"
    And I press "Log in"
    Then I should see "Signed in successfully."
    Then I should be on the Ecospot home page
    When I press "Add new Spot"
    Then I should be on Create new Spot page
    When I fill in "Name" with "Parco di Veio"
    And I fill in "Location" with "Roma"
    When I attach the file "/home/biar/Pictures/Wallpapers/02.jpg" to "Image"
    And I press "Create Spot"
    Then I should be on the Ecospot spot page
    When I follow "Back"
    And I should see "Parco di Veio"

