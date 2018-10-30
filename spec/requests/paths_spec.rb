require 'rails_helper'

RSpec.describe "Paths", type: :request do
  describe "GET /paths" do
    it "works! (now write some real specs)" do
      get paths_path
      expect(response).to have_http_status(200)
    end
  end
end
