require 'spec_helper'

describe "user_books/show" do
  before(:each) do
    @user_book = assign(:user_book, stub_model(UserBook))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
