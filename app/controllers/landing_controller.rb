class LandingController < ApplicationController
  def main
    @datum = Dataset.all.map do |d|
      {site_num: d.site_number, url: d.url_to_scan}
    end
  end
end
