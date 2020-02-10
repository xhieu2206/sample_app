require 'rails_helper'
require "spec_helper"

RSpec.describe StaticPagesController, type: :controller do

  describe "GET root" do
    it "responds successfully when go to root url" do
      get :home
      expect(response.status).to eq(200)
    end
  end

  describe "GET help" do
    # Example
    it "responds successfully when go to help url" do
      get :help
      expect(response.status).to eq(200)
    end
  end

  describe "GET contact" do
    # Example
    it "responds successfully when go to contact url" do
      get :contact
      expect(response.status).to eq(200)
    end
  end

  describe "GET about" do
    # Example
    it "responds successfully when go to about url" do
      get :about
      expect(response.status).to eq(200)
    end
  end
end