Feature: Create and Edit Categories
As a blog administrator
I want to be able to create new categories and edit existing ones

Background:
	Given the blog is set up
	And I am logged into the admin panel
	When I follow "Categories"

Scenario: It should be able to create and edit
	Then I should see "Categories"
	And I should see "Name"
	And I should see "Description"
	And I should see "Title"
	When I fill in "Name" with "Category1"
	And I press "Save"
	Then I should see "Category1"
	When I follow "Category1"
	And I fill in "Description" with "This is a test."
	And I press "Save"
	Then I should see "This is a test."

