Feature: Login

    As a registered user
    I want to log in to the website
    In order to have more features and opportunities.


    Scenario: Logging in successfully
    # Als erstes kommt immer das "Sunshine"-Scenario,
    # wo ich als User alles richtig mache, das System
    # perfekt läuft und es auch auf dem Backend keinerlei
    # Probleme gibt.

    # Leider kommt im richtigen Leben immer was dazwischen.
    # Deshalb muss man möglichst auch auf alle diese 
    # Fälle vorbereitet sein.

    Scenario: Signing up with an invalid email

    Scenario: Signing up with an invalid password

    Scenario: Logging in to a failing backend
    # Wie reagiert die App, wenn Firebase mal nicht so
    # läuft wie man es von ihm erwartet? Muss man
    # darüber nachdenken.

    Scenario: Logging in as logged-in user
    # Das kann in der App NICHT passieren, weil jemand
    # als eingeloggter User gar keinen Login-Button mehr 
    # findet! Aber es kann sein, dass man: 
    # https://localhost:8080/login
    # eingibt, nur um zu testen, ob die App gut darauf
    # reagiert! Da sollte eine entsprechende Meldung 
    # zurückgegeben werden.