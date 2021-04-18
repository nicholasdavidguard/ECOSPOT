require 'rails_helper'
require 'spec_helper'

RSpec.describe "User or Admin can add a spot" , type: :feature  do

    Spot.delete_all
    User.delete_all
    m=User.new(:id => '1' ,:name => 'Mario', :surname => 'Rossi', :date => '1998/02/02', :place => 'Roma', :email =>'mario.rossi@gmail.com', :password => 'password')
    m.save!

    scenario 'Add new Spot' do
        visit new_user_session_path
        fill_in "Email",	with: "mario.rossi@gmail.com" 
        fill_in "Password",	with: "password"
        click_on 'Log in'
        click_on 'Add new Spot'
        expect(page).to have_current_path("/spots/new")

        
        fill_in "Name",	with: "Pista Ciclabile Ponte Milvio"
        fill_in "Location",	with: "Ponte Milvio, Roma" 
        click_on 'Create Spot'
        click_on 'Back'
        expect(page).to have_content("Pista Ciclabile Ponte Milvio")
    
    
    end
end

    
