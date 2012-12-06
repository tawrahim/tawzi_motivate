# This file is test file for all the pages in the static_page controller
require 'spec_helper'

describe "Static Pages" do
  
  describe " Home page" do
  		
  	it "should have the content 'Tawzi'" do
  		visit '/static_pages/home'
  		page.should have_selector('h1', text: 'Tawzi')
  	end

  	it "should have the right title" do
  		visit '/static_pages/home'
  		page.should have_selector('title', text: "Tawzi | Home")
  	end

  end

  describe " Help page" do
  		
  	it "should have the content 'Help'" do
  		visit '/static_pages/help'
  		page.should have_selector('h1', text: 'Help')
  	end

  	it "should have the right title" do
  		visit '/static_pages/help'
  		page.should have_selector('title', text: "Tawzi | Help")
  	end

  end

  describe "About page" do
  		
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		page.should have_selector('h1', text: 'About')
  	end
  	
  	it "should have the right title" do
  		visit '/static_pages/about'
  		page.should have_selector('title', text: "Tawzi | About")
  	end
  end

  describe "Terms page" do
  		
  	it "should have the content Terms" do
  		visit '/static_pages/terms'
  		page.should have_selector('h1', text: 'Terms')
  	end
  	
  	it "should have the right title" do
  		visit '/static_pages/terms'
  		page.should have_selector('title', text: "Tawzi | Terms")
  	end
  end

end
