require 'rails_helper'

RSpec.describe Product, type: :model do
  %i(name image_url price installments url store_id).each do |attribute|
    it { should validate_presence_of(attribute) }
  end
end
