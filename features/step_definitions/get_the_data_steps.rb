Given("I visit the app root") do
  visit root_path
end

Given("I see a list of links") do
  within('ul') do
    a = all('li a')
    expect(a.count).to be > 1
  end
end

When("I follow the first link") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I see a well-formed CSV document") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("the CSV has a consistent number of columns throughout") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("the number of columns is not zero") do
  pending # Write code here that turns the phrase above into concrete actions
end

