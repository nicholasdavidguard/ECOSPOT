require 'rails_helper'
require 'spec_helper'

RSpec.describe "User or Admin can search users/spots" , type: :feature  do

    Spot.delete_all
    User.delete_all
    m=User.new(:id => '1' ,:name => 'Mario', :surname => 'Rossi', :date => '1998/02/02', :place => 'Roma', :email =>'mario.rossi@gmail.com', :password => 'password')
    a=User.new(:id=>'2', :name => 'Luigi', :surname => 'Bianchi', :date => '1998/08/08', :place => 'Roma', :email => 'luigi.bianchi@gmail.com', :password => 'password')
    s=Spot.new(:name => 'Bosco' , :location => 'Frosinone', :user_id =>'2')

    m.save!
    a.save!
    s.save!

    scenario 'User searchs a specific user' do
        visit new_user_session_path
        fill_in "Email",	with: "mario.rossi@gmail.com" 
        fill_in "Password",	with: "password"
        click_on 'Log in'
        expect(page).to have_current_path("/")

        fill_in 'search', with: 'Luigi'
        click_on 'Search'
        expect(page).to have_current_path("/search?utf8=%E2%9C%93&search=Luigi&commit=Search")
        expect(page).to have_content("Luigi")
    end

    scenario 'User searchs a specific Spot' do
        visit new_user_session_path
        fill_in "Email",	with: "mario.rossi@gmail.com" 
        fill_in "Password",	with: "password"
        click_on 'Log in'
        expect(page).to have_current_path("/")

        fill_in 'search', with: 'Bosco'
        click_on 'Search'
        expect(page).to have_content("Bosco")
    end
end