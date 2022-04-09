Feature: Navbar

    As a user
    I want to see a useful navbar
    In order to take me everywhere on the web site

    Scenario: Using the navbar as Guest user

    Scenario: Using the navbar as logged-in user
        When I look at the top of the viewport,
        Then I see a navbar
        And I see my username on the navbar
        And I see a little cart section in the navbar
        And I see a little bookmark section in the navbar
        And I see a catalog link on the navbar.

    # Das mit der Navbar ist im Moment ein bisschen schwierig, 
    # weil ich erst klare Vorstellungen über die anderen 
    # Features brauche, um zu entscheiden, was ich
    # am Ende in die Navbar aufnehmen will -- ganz 
    # besonders bei eingeloggten Usern.
    #
    # Deshalb hab ich die Navbar jetzt auch an das Ende 
    # der Liste gesetzt.