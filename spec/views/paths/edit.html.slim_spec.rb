require 'rails_helper'

RSpec.describe "paths/edit", type: :view do
  before(:each) do
    @path = assign(:path, Path.create!(
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders the edit path form" do
    render

    assert_select "form[action=?][method=?]", path_path(@path), "post" do

      assert_select "input[name=?]", "path[name]"

      assert_select "input[name=?]", "path[user_id]"
    end
  end
end
