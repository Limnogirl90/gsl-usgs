class LandingController < ApplicationController
  def main
    @links = Dataset.all.map(&:url_to_scan)
  end
end
