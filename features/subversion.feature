Feature: Subversion support
  As a user
  I want to be able to check out source code from Subversion

  @realupdatecenter
  Scenario: Install Subversion SCM
    When I install the "subversion" plugin from the update center
    And I create a job named "svn-test"
    Then the job should be able to use the "Subversion" SCM

  @realupdatecenter
  Scenario: Run basic Subversion build
    Given I have installed the "subversion" plugin
    And a job
    When I check out code from Subversion repository "https://svn.jenkins-ci.org/trunk/jenkins/test-projects/model-ant-project/"
    And I add a script build step to run "test -d .svn"
    And I save the job
    And I build 1 jobs
    Then the build should succeed
    And I should see console output matching "test -d .svn"

