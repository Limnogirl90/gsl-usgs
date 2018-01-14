require 'rails_helper'

RSpec.describe ApplicationController do

  controller do
    def index
      render :nothing => true
    end
  end

  it "has a landing page", api: true do
    get :index
    expect(response.status).to eq 200
  end

end
