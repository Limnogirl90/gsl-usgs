# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


sites = [
  411116112244401,
  411403112200801,
  10141000,
  411318112334001,
  411325112400701,
  10010020,
  410644112382601,
  410637112270401,
  10010000,
  404607112193801,
  10172630,
  410401112134801,
  410153112082301,
  10140700
]

attribs = sites.map do |s|
  { base_url: "https://waterdata.usgs.gov/nwis/inventory?agency_code=USGS&site_no=#{s}",
    site_number: s }
end
Dataset.create(attribs)
