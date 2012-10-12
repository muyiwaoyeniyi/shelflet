require "spec_helper"

describe UserBooksController do
  describe "routing" do

    it "routes to #index" do
      get("/user_books").should route_to("user_books#index")
    end

    it "routes to #new" do
      get("/user_books/new").should route_to("user_books#new")
    end

    it "routes to #show" do
      get("/user_books/1").should route_to("user_books#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_books/1/edit").should route_to("user_books#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_books").should route_to("user_books#create")
    end

    it "routes to #update" do
      put("/user_books/1").should route_to("user_books#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_books/1").should route_to("user_books#destroy", :id => "1")
    end

  end
end
