require 'rails_helper'

# feature "the signup process" do
#
#   scenario "has a new user page" do
#     visit new_user_url
#     expect(page).to have_content "New user"
#   end
#
#   feature "signing up a user" do
#     before(:each) do
#       visit new_user_url
#       fill_in 'username', with: "testing_username"
#       fill_in 'password', with: "biscuits"
#       click_on "Create User"
#     end
#
#     scenario "shows username on the homepage after signup" do
#       expect(page).to have_content "testing_username"
#     end
#   end
# end

feature "create goal process" do
  before(:each) do
    visit new_session_url
    fill_in 'username', with: "hello2"
    fill_in 'password', with: "helloworld2"
    # save_and_open_page
    click_on "Login"
    
    #save_and_open_page
    # p new_user_goal_url(user_id: 1)
    click_on "Create Goal"
    fill_in 'goal', with: "my new goal"
    choose 'yes_to_private'
    click_on "Create Goal"
  end
  
  feature "user creates private goal" do
    scenario "has a new goal" do
      visit goal_url(1)
      expect(page).to have_content "my new goal"
    end
  end
  
  feature "other user cannot see first user goad" do 
    before(:each) do 
      visit new_user_url
      fill_in 'username', with: "testing_username2"
      fill_in 'password', with: "biscuits2"
      click_on "Create User"
    end
    
    scenario "can't see goal" do
      visit goals_url
      expect(page).not_to have_content "my new goal"
    end
  end
  
  scenario "user can update their goals" do
    visit edit_goal_url(1)
    fill_in 'goal', with: "my newer very much better goal"
    choose 'private'
    click_on "Update Goal"
    
    visit user_goal_url(1)
    expect(page).to have_content "my newer very much better goal"
  end
  
  scenario "user can destroy their goals" do
    visit user_goal_url(1)
    click_on "Destroy Goal"
    
    visit user_goal_url(1)
    expect(page).not_to have_content "my newer very much better goal"
  end
end


  
  