Feature: Cleanup job workspace
  As a Jenkins user
  I want to automatically cleanup my workspace

  @realupdatecenter
  Scenario: Install Workspace cleanup plugin
    Given a simple job
    When I install the "ws-cleanup" plugin from the update center
    Then I should be able to configure workspace cleanup

  @realupdatecenter
  Scenario: Do not clean up by default
    Given I have installed the "ws-cleanup" plugin
    And a simple job
    When I configure the job
    And I add a script build step to run "touch artifact"
    And I save the job
    And I build the job
    Then there should be "artifact" in the workspace

  @realupdatecenter
  Scenario: Clean up after build
    Given I have installed the "ws-cleanup" plugin
    And a simple job
    When I configure the job
    And I add a script build step to run "touch artifact"
    And I add "Delete workspace when build is done" post-build action
    And I build the job
    Then there should not be "artifact" in the workspace

  @realupdatecenter
  Scenario: Clean up before build
    Given I have installed the "ws-cleanup" plugin
    And a simple job
    When I configure the job
    And I check the "hudson-plugins-ws_cleanup-PreBuildCleanup" checkbox
    # Creating directory that already exists would fail the build
    And I add a script build step to run "mkdir artifact.d"
    And I save the job
    And I build 2 jobs
    Then the build should succeed
    And there should be "artifact.d" in the workspace
