Feature: View Product from Catalog

    # 
    #

    As a logged-in or not logged-in user
    I want to see the individual item in a full mode
    In order to see either more pics about the selected item 
    Or to choose the wanted size and color

    Background: Logged-in user

        Scenario: Opening the "itemView" page
            When I click on an item on the Catalogue page,
            Then I see more related photos about the item on "itemView"-page 
            And more information about the size, color, price and the item
            And the user can scroll right and left between the item photos
            or to see the full view the picture by clicking on it with black background as a modal


    Background: Unlogged-in user

        Scenario: Opening the "itemView" page
            When I click on an item on the Catalogue page,
            Then I see more related photos about the item on "itemView"-page 
            And more information about the size, color, price and the item
            But the difference here is that the boxes of the Size 
            And Color are deactivate, until the user logged in

