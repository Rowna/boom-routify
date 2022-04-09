Feature: Landing Page

    As a user
    I want to experience a strong landing page
    In order to be well oriented on the web page

    Background: Being a guest user
        Scenario: Opening the landing page
            When I arrive on the landing page
            Then I see a welcome hero
            And on the hero I see a title and a friendly subtitle,
            #
            And I see a mini card catalog of kid-modelling
            #
            And I see a navbar for guests showing "Sign Up" and "Login"

    Background: Being a logged-in user
        Scenario: Opening the landing page
        When I arrive on the landing page,
        Then I see everything a guest user sees
        But I also see Bookmark Hearts on card items
        And I see the navbar version for logged-in users. 

