Feature: Sign-Up

    As a guest user
    I want to sign up to the web site
    In order to have more features and opportunities.


    Scenario: Signing up successfully
    # Als erstes kommt immer das "Sunshine"-Scenario,
    # wo ich als User alles richtig mache, das System
    # perfekt läuft und es auch auf dem Backend keinerlei
    # Probleme gibt.

    # Leider kommt im richtigen Leben immer was dazwischen.
    # Deshalb muss man möglichst auch auf alle diese 
    # Fälle vorbereitet sein.

    Scenario: Signing up with invalid email

    Scenario: Signing up with an invalid password

    Scenario: Signing up as a logged-in user
    # Sowas kann passieren, wenn die sessions nach
    # Verlassen der Seite nicht zurückgesetzt werden
    # und man auch noch am nächsten Tag automatisch
    # eingeloggt ist, weil man sich am Tag vorher
    # nicht ausgeloggt hat und auch das System
    # sich nicht ausgeloggt hat.
    #
    # Da muss man sich genau bei Firebase erkundigen,
    # wie dort das Session-Management mit den Web-Token
    # funktioniert.

    Scenario: Signing up to a failing backend
    # Wie reagiert die App, wenn Firebase mal nicht so
    # läuft wie man es von ihm erwartet? Muss man
    # darüber nachdenken.