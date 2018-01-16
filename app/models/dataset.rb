class Dataset < ApplicationRecord
  def url_to_scan
    base_url + site_number
  end
end
