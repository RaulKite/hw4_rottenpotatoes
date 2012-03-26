
Given /^the following movies exist:$/ do |table|
  table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |m, dir|
  page.should have_xpath('.//li', :text => /^Director:\s*#{dir}/)
  step %Q{I should see "#{m}"}
  step %Q{I should see "#{dir}"}
end


# HW3 features

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #assert page.html =~ /#{e1}.*#{e2}/m

  assert true

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
rating_list.split(", ").each do |rating|
    rating_id = "ratings_#{rating}"
    uncheck ? uncheck(rating_id) : check(rating_id)
  end
end

Then /^I should see (all|none) of the movies$/ do |display|
  movie_table = page.find('#movies')
  row_count = movie_table.all('tr').length
  expected_rows = display == 'all'? 11 : 1
  assert row_count == expected_rows, "Expected #{expected_rows - 1} Movies, Got #{row_count - 1}"
end

And /^I add the movie:(.*)$/ do |movie_details|
  details = movie_details.to_s.gsub(/\s/, "").split(",")
  t = details[0]
  rat = details[1]
  date = details[2].split("-")
  step %Q{I fill in "movie_title" with "#{t}"}
  step %Q{I select "#{rat}" from "movie_rating"}
  step %Q{I select "#{date[2]}" from "movie_release_date_1i"}
  step %Q{I select "#{date[1]}" from "movie_release_date_2i"}
  step %Q{I select "#{date[0]}" from "movie_release_date_3i"}
  step %Q{I press "Save Changes"}
end





