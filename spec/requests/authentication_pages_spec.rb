require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "Sign page" do
    before { visit signin_path }

    # The save and open page paramenter allows that test to open in a page
    # it { save_and_open_page; should have_selector('h1', text: 'Sign in')}
    it { should have_selector('h1', text: 'Sign in')}   
    it { should have_selector('title', text: 'Sign in')}
  end

	describe "signin" do
	    before { visit signin_path }

	    describe " with invalid information" do
	      before {click_button "Sign in"}

	      it { should have_selector('title', text: 'Sign in')}
	      it { should have_selector('div.alert.alert-error', text: 'Invalid')}

	      describe "after visiting another page" do 
	        before { click_link "Home" }
	        it { should_not have_selector('div.alert.alert-error')}
	      end 
	    end


	    describe "with valid information" do
	      let(:user) { FactoryGirl.create(:user) }
	      
        # The sign in method is defined in the utilities file  
        before { sign_in user}

	      it { should have_selector('title',      text: user.name) }
	      it { should have_link('Profile',        href: user_path(user)) }
	      it { should have_link('Sign out',       href: signout_path) }
	      it { should have_link('Settings' ,      href: edit_user_path(user))}
         it { should have_link('Users',         href: users_path) }
	      it { should_not have_link('Sign in',    href: signin_path) }

	      describe "followed by signout" do
        	before { click_link "Sign out" }
        	it { should have_link('Sign in')}
        end
	    end	    
 	end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user)}

      describe "when attempting to visit a protected page" do
        before do
            visit edit_user_path(user)
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
        end

        describe "after signin it" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit User')
          end

          describe "when signing again" do
            before do
              click_link "Sign out" 
              click_link "Sign in"
              visit edit_user_path(user)
              fill_in "Email", with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"                
            end

            it "should render the default (Profile) page" do
              #page.should have_selector('title', text: user.name)
            end
          end
        end
      end

      describe "in the users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in')}
          it { should have_selector('div.alert.alert-notice')}
        end

        describe "submitting to the update action" do
          before { put user_path(signin_path) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path}
          it { should have_selector('title', text: 'Sign in')}
        end
      end
    end

    describe "wrong users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@email.com")}
      before { sign_in user}

      describe "visiting User#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Edit user') }
      end

      describe "submitting a PUT request to the User#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path)}       
      end

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user_path) }
        let(:non_admin) { FactoryGirl.create(:user_path) }

        before { sign_in non_admin }

        describe "submitting a DELETE request to the User#destroy action " do
          before { delete user_path(user)}
          specify { response.should redirect_to(root_path)}
        end
      end  
    end
  end
end
