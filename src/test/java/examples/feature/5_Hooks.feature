Feature: Hooks Demo

Background: Hooks
    * print 'This is Before Scenario'

    # after scenario
    * configure afterScenario = 
    """
        function() {
            karate.log('This is After Scenario Test');
        }
    """
    * configure afterFeature = function() {karate.log('This is After Feature Test');}

Scenario: First scenario
    * print 'This is First Test Scenario'

Scenario: Second scenario
    * print 'This is Second Test Scenario'