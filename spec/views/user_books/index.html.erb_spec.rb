require 'spec_helper'

describe "user_books/index" do
  before(:each) do
    assign(:user_books, [
      stub_model(UserBook),
      stub_model(UserBook)
    ])
  end

  it "renders a list of user_books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
