require 'rails_helper'

RSpec.describe "paths/index", type: :view do
  before(:each) do
    assign(:paths, [
      Path.create!(
        :name => "Name",
        :user => nil
      ),
      Path.create!(
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of paths" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
