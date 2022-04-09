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

    Background: Using the catalog
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

        Scenario: Setting a Bookmark
            Given A heart button on a card is empty,
            When I click on an item's heart button,
            Then I am being redirected to showing "Bookmarked"-article


