require 'spec_helper'

describe "user_books/edit" do
  before(:each) do
    @user_book = assign(:user_book, stub_model(UserBook))
  end

  it "renders the edit user_book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_books_path(@user_book), :method => "post" do
    end
  end
end
