require 'rails_helper'

RSpec.describe "paths/show", type: :view do
  before(:each) do
    @path = assign(:path, Path.create!(
      :name => "Name",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
