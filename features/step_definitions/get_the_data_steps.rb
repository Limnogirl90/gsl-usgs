require "csv"

def follow_link_please(nth)
  links = all('li a')
  link = links[nth]
  link_text = link.text
  @data_number = link_text
  link.click

  follow_link_for_csv_data(link_text)
end

def follow_link_for_csv_data(link_text)
  # Follow the link to water-quality samples
  find('a', text: 'Field/Lab water-quality samples', wait: 15).click

  # Set options
  find('select[name="rdb_inventory_output"]', wait: 15).
    find('option[value=value]').select_option

  # Submit
  find('input#search_submit_button').click
  save_page(link_text)
end

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
  follow_link_please(0)
end

Then("I see a well-formed CSV document") do
  html_document = File.read( "tmp/capybara/#@data_number" )
  hdoc = Nokogiri::HTML( html_document )

  csv_document = hdoc.css('pre').text

  parsed_file = CSV.parse(csv_document, { :col_sep => "\t" })

  @csv_lines = []
  @comment_lines = []

  parsed_file.each do |line|
    if line.count == 1 && line.grep(/^#/).any?
      @comment_lines << line
    else
      @csv_lines << line
    end
  end
end

Then("the CSV has a consistent number of columns throughout") do
  @count_to_expect = @csv_lines.first.count
  @csv_lines.each do |line|
    expect(line.count).to eq @count_to_expect
  end
end

Then("the number of columns is not zero") do
  @count_to_expect = @csv_lines.first.count
  expect(@count_to_expect).not_to eq 0
end

When("I follow the rest of the links and collect their CSV") do
  links = all('li a')

  count = 0
  links.each do |link|
    link_text = link.text
    @data_number = link_text


    puts "(sub) I follow the #{count} link"
    follow_link_please(count)

    count += 1
    visit root_path
  end
end

Then("each of my CSVs are well-formed CSV document") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("each of my CSVs has a consistent number of columns throughout") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("each of my CSVs has a number of columns that is not zero") do
  pending # Write code here that turns the phrase above into concrete actions
end
