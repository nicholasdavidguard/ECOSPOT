require 'rails_helper'
require 'spec_helper'



RSpec.describe "User or Admin can like/dislike a Spot" , type: :feature   do


    Spot.delete_all
    User.delete_all
    m=User.new(:id => '1' ,:name => 'Mario', :surname => 'Rossi', :date => '1998/02/02', :place => 'Roma', :email =>'mario.rossi@gmail.com', :password => 'password')
    m.save!

    scenario 'Like existing Spot'   do
        

        visit new_user_session_path
        fill_in "Email",	with: "mario.rossi@gmail.com" 
        fill_in "Password",	with: "password"
        click_on 'Log in'
        expect(page).to have_current_path("/")

        click_on 'Add new Spot'
        expect(page).to have_current_path("/spots/new")
        
        fill_in "Name",	with: "Bosco"
        fill_in "Location",	with: "Frosinone" 
        click_on 'Create Spot'
        click_on "Back"
        expect(page).to have_current_path("/spots")

        fill_in 'search', with: 'Bosco'
        click_on 'Search'
        expect(page).to have_content("Bosco")

        

        


        old_likes = Spot.find_by(:name => 'Bosco').get_likes.size
        expect(old_likes).to eq(0)
        page.find_by_id('likes_id').click
        expect(page).to have_current_path("/spots")
        expect(page).to have_content("Bosco")
        new_likes = Spot.find_by(:name => 'Bosco').get_likes.size
        expect(new_likes).to eq(1)


    end
end