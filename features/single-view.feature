Feature: Single View

    # Man Catalog

    As a user, guest or logged-in
    I want to see dedicated single views of catalog items
    In order to learn more about them and to decide whether to buy them.

    Background: Being a guest user

        Scenario: Opening the Single View page of an article
            Given I have clicked on the title, image or price in the catalog view,
            When the Single View page oppens up,
            Then I see all the images belonging to that item in a thumbnail gallery,
            And I see the title of the item
            And I see the price of the item
            And I see the full description of the item
            And I see special infos about the item (see wireframe!)

    Background: Being a logged-in user

        Scenario: Opening the Single View page of an article

            Given I have clicked the title, image or price in the catalog view,
            When the Single View page opens up,
            Then I see everything a guest user sees
            #
            Given the item is not listed in my cart
            Then I see an "Add To Cart" button
            Given the item is indeed listed to my cart
            Then I see an "In the cart" message
            # kann auch ein farbiges Cart Icon sein
            # -------
            And I also see the recommendations of other users listed below
            And I also see an "Add a recommendation" button, and
            When I click on that button
            Then a modal pops up for entering a new recommendation.
            # -------

        Scenario: Adding the item to the cart successfully
            When I click on the "Add to cart" button
            Then I see a little popup dialoge showing "Added"
            And the Cart item in the navbar is being updated
            # kann auch ein farbiges Cart Icon sein.

            

        
