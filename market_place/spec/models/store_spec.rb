require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    %i(name website email encrypted_password).each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end
end
