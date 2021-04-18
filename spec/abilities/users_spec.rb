require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#users' do
  let(:acting_User) { User.create(roles: %w(User)) }
  subject(:User_ability) { Ability.new(acting_User) }

  describe 'on Spot' do
    let(:Spot) { Spot.create }

    it { is_expected.to be_able_to(:create, Spot) }
    it { is_expected.to be_able_to(:read, Spot) }
    it { is_expected.to be_able_to(:update, Spot) }
    
  end
  # on Spot
end
