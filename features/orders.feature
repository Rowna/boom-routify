Feature: Orders

    As a logged-in users
    I want to order the items in my cart
    In order to own and enjoy them


    Scenario: Using the Shopping-Cart as Guest user

    Scenario: Using the navbar as logged-in user
        When I want to make an order,
        Then I see a Button with Cart-icon,
        And I click on it, in order to add this order in Shopping-cart

    Scenario: Shopping-cart as logged-in user
        When I order the articels I can see them in Shopping-cart,
        And I see two Buttons "Paying" and "back to Gallery"
        And I click on "Paying", 
        Then ...
        # Das wird aufgerufen, wenn einer "Check The Bill" klickt.
        # An dieser Stelle wuerden jetzt die 
        # Bestellungsmodalitäten mit Lieferadresse, 
        # Bankverbindung oder PayPal erscheinen. Da 
        # hier Vertragsrecht und andere gesetzliche 
        # Regelungen genau eingehalten werden müssen, 
        # möchte ich es an dieser Stelle bei diesem 
        # erklärenden Hinweis belassen.

        # Button [Ich habe Verstaendnis]  


# Erste Gedankne: 
# Beil Klicken auf den Button "Add-to-Cart" in "CatalogItem.svelte",
# und wenn der User sich eingeloggt ist, 
# wird "users/{$user.uid}/cart" um diesen Artikel erweitert.
# deshalb war es mir so wichtig, die userID aus
# firebase Auth zur Doc-ID bei "users" zu machen.

# Hier hab ich eindeutig Entscheidungsbedarf!
# Will ich auf der "Order page" einfach nur sagen:
# "Nicht implementiert, weil dieses Projekt ein akademisches Projekt ist."?
# Denn wenn ich Bestellungen mache, muss ich auch über Lieferanschriften reden,
# über Bankverbindungen und über Überweisungen, vielleicht sogar über PayPal
# oder GiroPay.
#
# Im Moment kann ich deshalb kein Feature formulieren.
