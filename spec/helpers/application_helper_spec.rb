# This file is test file for the application helper

require 'spec_helper'

describe ApplicationHelper do

	describe "full_title" do

		it "it should include the page title " do
			full_title('foo').should =~ /foo/
		end
		
		it "it should include the base title " do
			full_title('foo').should =~ /^Tawzi/
		end	

		it "it should not include a bar on the home page " do
			full_title('').should_not =~ /\|/
		end	
	end
end
