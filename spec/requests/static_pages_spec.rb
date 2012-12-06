# This file is test file for all the pages in the static_page controller

require 'spec_helper'

describe "Static Pages" do

  # Here we are telling Rspec that the subject of this test should be page
  subject { page }
  
  describe " Home page" do

    # The before block runs first before any it block, basically it runs before the it in
    # in this static pages block
    before { visit root_path }
    
    it { should have_selector('h1', text: 'Tawzi') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: "| Home") } 
  end

  describe " Help page" do
    before { visit help_path }  
    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_selector('h1', text: 'About') }
    it { should have_selector('title', text: full_title('About')) }
  end

  describe "Terms page" do
    before { visit terms_path }
    it { should have_selector('h1', text: 'Terms') }
    it { should have_selector('title', text: full_title('Terms')) }
  end

  it "should have the right links on the layout " do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Terms"
    page.should have_selector 'title', text: full_title('Terms')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end

end
