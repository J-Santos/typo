Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create!(article)
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /the following comments exist/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create!(comment)
  end
end

Given /^I am logged into the admin panel "(.*)"$/ do |login|
  visit '/accounts/login'
  fill_in 'user_login', :with => login
  fill_in 'user_password', :with => login + "_1"
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

And /^I (re)?visit the edit page of "(.*)"$/ do |re, title|
  visit 'admin/content/edit/' + Article.find_by_title(title).id.to_s
end

Then /^I should not see the button "(.*)"$/ do |button|
  page.should have_no_button(button)
end

Then /I should see the body text of "(.*)" including "(.*)" and "(.*)"/ do |e1,e2,e3|
  assert Article.find_by_title(e1).body.include?(e2)
  assert Article.find_by_title(e1).body.include?(e3)
end
Given /I merged articles "(.*)" and "(.*)"$/ do |a1,a2|
	Article.find_by_title(a1).merge_with(Article.find_by_title(a2).id)
end 

Then /"(.*?)" should be author of (\d+) articles$/ do |user, count|
  assert Article.find_all_by_author(User.find_by_name(user).login).size == Integer(count)
end

Then /I should see the comments of "(.*)" including "(.*)" and "(.*)"/ do |e1,e2,e3|
  #puts 	Feedback.find_all_by_article_id(Article.find_by_title(e1).id).include?(e2)
  merged_comments = Array.new
  article_1 = Article.find_by_title(e1).comments
  article_1.each do |comment|
  	merged_comments << comment.body
  end
  #puts merged_comments
  assert merged_comments.include?(e2) and merged_comments.include?(e3)
end

Then /I should see the title of "(.*)"$/ do |e1| #and not the title of "(.*)"/ do |e1,e2|
  merged_title = Array.new
  Article.all.each do |article|
  	merged_title << article.title
  end
  #puts merged_title
  assert merged_title.include?(e1) 
end

And /I should not see the existance of "(.*)"$/ do |art|
	expect(Article.find_by_id(art)).to be_nil
end


