require 'spec_helper'

describe "user_books/new" do
  before(:each) do
    assign(:user_book, stub_model(UserBook).as_new_record)
  end

  it "renders new user_book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_books_path, :method => "post" do
    end
  end
end
