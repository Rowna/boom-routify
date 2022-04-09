Feature: Bookmarks

    # Bookmarks können überall in einem Katalog mit einem Klick
    # auf das Herz-Symbol gesetzt werden.

    As a logged-in user
    I want to see my bookmarked items in a special list
    In order to avoid searching over and over again

    Background: Logged-in user

        Scenario: Opening the "Bookmarks" page
            When I click on the heart-symbol "My Bookmarks" link in the navbar,
            Then I see a special Catalogue of item cards on the page,
            And the cataloge here works exactly like the normal catalogue for logged-in-users.

        Scenario: Unsetting a Bookmark
            When I open the Bookmark site, I see a list with favourite article
            Then on each article on the right side I see "X", 
            Then with on click on "X" the item will be deleted from the list
