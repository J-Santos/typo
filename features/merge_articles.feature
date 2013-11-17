Feature: Merge Articles
	As a blog administrator
	In order to reduce duplication on the blog
	I want to merge two similar articles into one

Background:
	Given the blog is set up
	Given the following articles exist:
	| title 	| author   	 | body 	 | published   | id |	
	| Article1  | noAdmin    | Content1  | true 	   | 3	|	
	| Article2  | admin1  	 | Content2  | true 	   | 4	|	

	Given the following users exist:
	| login   | password  | email 				| name 		  | profile_id |
	| noAdmin | noAdmin_1 | noAdmin@example.com | Pub_noAdmin | 2 		   |
	| admin1  | admin1_1  | admin@example.com 	| Pub_admin1  | 1 		   |

	Given the following comments exist: 

	| type    | author    | body     | article_id | 
	| Comment | noAdmin   | Comment1 | 3		  | 
	| Comment | admin1    | Comment2 | 4		  | 

Scenario: A non-admin cannot merge articles.
	Given I am logged into the admin panel "noAdmin"
	And I visit the edit page of "Article1"
	Then I should see "New Article"
	Then I should not see "Merge Articles"

Scenario: An admin can merge articles.
	Given I am logged into the admin panel "admin1"
	And I visit the edit page of "Article1"
	Then I should see "Merge Articles"

Scenario: The merged article should contain the text of both previous articles.
	Given I am logged into the admin panel "admin1"
	And I visit the edit page of "Article2"
	When I fill in "merge_with" with "3"
	And I press "Merge"
	Then I should be on the admin content page
	And I should see "Articles successfully merged!"
	And I revisit the edit page of "Article2"
	Then I should see the body text of "Article2" including "Content1" and "Content2"

Scenario: The merged article should have one author (either one of the originals)
	Given I merged articles "Article2" and "Article1"
	Then "Pub_admin1" should be author of 1 articles
	And "Pub_noAdmin" should be author of 0 articles

Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
	Given I merged articles "Article2" and "Article1"
	And I am on the home page
	And I revisit the edit page of "Article2"
	Then I should see the comments of "Article2" including "Comment1" and "Comment2"

Scenario: The title should be either one of the merged articles
	Given I merged articles "Article2" and "Article1"
	Then I should see the title of "Article2" 
	And I should not see the existance of "Article1"
	
