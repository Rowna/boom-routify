Feature: Catalog

    As a user, guest or logged in
    I want to have a well-organized catalog of items
    In order to have fun browsing, choosing and ordering items

    Background: Being a guest user

        Scenario: Using the catalog
            When I open the dedicated catalogue page
            Then I see a random collection of sample items
            And for every item I see an image
            And I see the title
            And I see the price, And
            When I click on the "article" 
            Then I am being redirected to its single-article page

    Background: Being a logged-in user

        ### DONE ! ####
        Scenario: Using the catalog          
            Given I am a logged-in user,
            When I open the dedicated catalogue page,
            Then I see some kind of categories sidebar
            And I see a random collection of sample items
            And for every item I see an image
            And I see the title
            And I see the the price
            And I see a "cart" button with a cart symbol,
            And I see a "bookmark" button with a heart symbol.

            When I click on the image, or on its title or price on some item,
            Then I am being redirected to its single-article page

        Scenario: Adding an article to the Cart
            Given A cart button on a card is just outlined,
            When I click on the "Add-to-Cart" button,
            Then the cart symbol becomes 'filled'
            And the article will later appear in my cart list.

        Scenario: Removing an article from the Cart
            Given A cart button on a card is filled,
            When I click on the "Add-to-Cart" button,
            Then the cart symbol becomes outlined again
            And the article will no longer appear in my cart list.

        Scenario: Setting a Bookmark
            Given A heart button on a card is outlined,
            When I click on an item's heart button,
            Then the heart button will be filled
            And the article will later appear on the "My Favourites" list

        Scenario: Unsetting a Bookmark
            Given A heart button on a card is filled,
            When I click on that heart button,
            Then the heart button will be just outlined again
            And the article will no longerappear on the "My Favourites" list


