require "csv"

def manhandle_into_csv_hash_array(data_number)
  html_document = File.read( "tmp/capybara/#{data_number}" )
  hdoc = Nokogiri::HTML( html_document )

  csv_document = hdoc.css('pre').text

  parsed_file = CSV.parse(csv_document, { :col_sep => "\t" })

  csv_lines = []
  comment_lines = []

  parsed_file.each do |line|
    if line.count == 1 && line.grep(/^#/).any?
      comment_lines << line
    else
      csv_lines << line
    end
  end
  @hash_array ||= []
  @hash_array << {comment: comment_lines, csv: csv_lines}

  CSV.open("tmp/capybara/#{data_number}.csv", 'wb') do |csv|
    csv_lines.each { |line| csv << line }
  end

  File.open("tmp/capybara/#{data_number}.txt", 'w+') do |file|
    comment_lines.each { |line| file.puts line }
  end

  csv_lines
end

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
  find('a', text: 'Field/Lab water-quality samples', wait: 30).click

  # Set options
  find('div.radioLine', text: 'Parameter Group Period of Record table')
  find('input[type=radio][value=qw_sample_por_table]').click

  find('div.radioLine', text: 'Tab-separated data')
  find('input[type=radio][value=rdb]').click

  find('select[name=rdb_compression]').
    find('option[value=value]').select_option

  # Submit
  find('input#search_submit_button').click
  save_page(link_text)
end

Given("I visit the app root") do
  visit root_path
end

Given("I see a list of links") do
  links = all('li a')
  within('ul') do
    expect(links.count).to be > 1
  end

  max_count = links.count
  @data_numbers = []
  count = 0
  [*count..(max_count-1)].each do |i|
    link = links[i]
    link_text = link.text
    @data_numbers << link_text
  end
end


When("I follow the first link") do
  follow_link_please(0)
end

Then("I see a well-formed CSV document") do
  @csv_lines = manhandle_into_csv_hash_array(@data_number)
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
  max_count = links.count
  @data_numbers = []

  count = 0
  [*count..(max_count-1)].each do |i|
    link = links[i]
    link_text = link.text
    @data_numbers << link_text

    puts "(sub) I follow the #{count} link"
    follow_link_please(count)

    count += 1
    visit root_path
    links = all('li a')
  end
end

Then("each of my CSVs are well-formed CSV document") do
  @data_numbers.each do |num|
    manhandle_into_csv_hash_array(num)
  end

  expect(@hash_array.count).to eq 14
end

Then("each of my CSVs has a consistent number of columns throughout") do
  expect(@hash_array.count).to_not eq 0
  expect(@hash_array.count).to be_positive
  @hash_array.each do |document|

    csv = document[:csv]
    count_to_expect = csv.first.count
    document[:csv].each do |csv|
      expect(csv.count).to eq count_to_expect
    end
  end
end

Then("each of my CSVs has a number of columns that is not zero") do
  expect(@hash_array.count).to_not eq 0
  expect(@hash_array.count).to be_positive
  @hash_array.each do |document|

    csv = document[:csv]
    count_to_expect = csv.first.count
    expect(count_to_expect).to_not eq 0
  end
end
