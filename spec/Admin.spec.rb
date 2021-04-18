require 'rails_helper'
require 'spec_helper'

RSpec.describe "Admin abilities" , type: :feature  do

    Spot.delete_all
    User.delete_all
    m=User.new(:id => '1' ,:name => 'Mario', :surname => 'Rossi', :date => '1998/02/02', :place => 'Roma', :email =>'mario.rossi@gmail.com', :password => 'password')
    a=User.new(:id=>'2', :name => 'Luigi', :surname => 'Bianchi', :date => '1998/08/08', :place => 'Roma', :email => 'luigi.bianchi@gmail.com', :password => 'adminpass', :admin => 'true')
    m.save!
    a.save!

    scenario 'Admin search someone_s spot and deletes it ( because he can )' do
        visit new_user_session_path
        fill_in "Email",	with: "mario.rossi@gmail.com" 
        fill_in "Password",	with: "password"
        click_on 'Log in'
        click_on 'Add new Spot'
        expect(page).to have_current_path("/spots/new")
        
        fill_in "Name",	with: "Pista Ciclabile Ponte Milvio"
        fill_in "Location",	with: "Ponte Milvio, Roma" 
        click_on 'Create Spot'
        click_on "Back"
        expect(page).to have_current_path("/spots")

        click_on "Logout"

        expect(page).to have_current_path("/users/sign_in")

        fill_in "Email",	with: "luigi.bianchi@gmail.com" 
        fill_in "Password",	with: "adminpass"
        click_on 'Log in'

        fill_in 'search', with: 'Pista Ciclabile Ponte Milvio'
        click_on 'Search'
        find(:xpath, "//a/img[@alt='spot_image']/..").click
        click_on 'Delete'
        expect(page).to have_no_content("Pista Ciclabile Ponte Milvio")
    
    
    end
end