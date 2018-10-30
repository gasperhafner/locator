require 'rails_helper'

RSpec.describe "paths/new", type: :view do
  before(:each) do
    assign(:path, Path.new(
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders new path form" do
    render

    assert_select "form[action=?][method=?]", paths_path, "post" do

      assert_select "input[name=?]", "path[name]"

      assert_select "input[name=?]", "path[user_id]"
    end
  end
end
