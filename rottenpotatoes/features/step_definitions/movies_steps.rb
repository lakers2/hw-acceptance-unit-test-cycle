
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end
Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  split_list = rating_list.split(",")
  #   iterate over the ratings and reuse the "When I check..." or
  split_list.each do |rating|
    rating.tr!("\"",'').strip!
    if not uncheck
      check("ratings_#{rating}")
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
    else
      uncheck("ratings_#{rating}")
    end
  end
  
  # fail "Unimplemented"
end


Then /I should see all the movies: (.*)/ do |rating_list|
  # Make sure that all the movies in the app are visible in the table

  split_list = rating_list.split(",") 
  expect_count = 0
  split_list.each do |rating|
    rating.tr!("\"","").strip!
    expect_count += Movie.where(rating: rating).count
  end
  
  real_count = page.all("tr").count - 1
  
  expect(real_count).to be == (expect_count)
  # real_count.should == expect_count
end