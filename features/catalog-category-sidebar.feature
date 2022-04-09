Feature: Catalogue Category Sidebar

    As a logged-in user
    I want to see a category sidebar on the catalogue
    In order to browse only through dedicated categories

    Scenario: Using the Category sidebar in the catalogue
        Given I am a logged-in user
        When I open the dedicated catalogue page
        Then I see the catalogue card list
        And on the left I see a sidebar
        And on the sidebar I see a "Girls" checkbox
        And I see a "Boys" checkbox
        And I see a "Fashion" link
        And I see a "Toys" link
        And when I check the "Girls" checkbox
        Then the catalogue items are reduced to girls' items
        And when I check the "Boys" checkbox
        Then the catalogue items are reduced to boys' items
        And when I click on the "Fashion" link
        Then the catalogue is reduced to fashion items
        And so to other categories, respectively.