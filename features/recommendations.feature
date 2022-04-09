Feature: Recommendations
# muss korrigiert oder gelöscht werden

    As a user
    I want to see and write recommendations for the items
    In order to make better buying decisions.


    Background: Single View page as guest user

        Scenario: Browsing existing recommendations
            Given I am a guest user 
            When I have opened a Single View Page
            Then I see a list of existing recommendations
            And they are ordered by "latest item first",
            #
            And each recommendation has is author
            And it has the date of writing
            And it has the star-based ranking for the item
            And it shows the comment of the author.

    Background: Single View page as logged-in user

        Scenario: Browsing existing recommendations
            Given I am a logged-in user 
            When I have opened a Single View Page
            Then I see the same as a guest user sees
            But I also see a "Add Your Recommendation" button.

        Scenario: Writing a recommendation successfully
            When I click on the "Add Your Recommendation" button
            Then a text field opens up
            And below a "Submit" button,
            And I can write my own recommendation into the text field, and
            When I click on the "Submit" button
            Then my new recommendation is written to the database
            And appears on top of the list as the newest recommendation.

        Scenario: Writing the recommendation with backend error
            When I write a recommendation
            And I submit it
            And the app receives a backend error,
            Then a new message appears below the "Submit" button
            And it tells me to try again later.