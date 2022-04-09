Feature: Shopping Cart

    As a logged-in user
    I want to add catalog items to a shopping cart
    In order to prepare my next order

    Scenario: Opening the shopping cart page
        Given I am logged in,
        When I open the Cart page from the navbar "Shopping Cart" link,
        Then I see a catalog of all the items in my Cart,
        And I see a "Remove" button on every single item in the list with an "X",
        And I see an "Add to Shopping Cart" button on the page,
        And I see a "Back to Gallery" Button on the bottom of the Site.

    Scenario: Removing an item from the Cart List
        When I click on the "Remove" button on one of the Cart items,
        Then the item gently disappears from the list 
        And is taken out of the cart list.

    Scenario: Add the order
        When I click on the "Add to Shopping Cart" button
        Then the item will be added to my shopping cart with the chosen quantity

# Ich muss noch nachdenken, ob ich die Cart-Liste in Firebase aufnehme
# oder einfach in einem localstore, d.h. im Browser speichere. 
# Ich kann im Moment nicht sagen, was besser ist.
