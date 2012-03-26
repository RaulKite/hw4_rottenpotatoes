
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


