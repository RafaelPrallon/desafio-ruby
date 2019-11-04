class Product
  include Mongoid::Document

  belongs_to :store
  field :name, type: String
  field :image_url, type: String
  field :price, type: Float
  field :installments, type: Integer
  field :url, type: String

  %i(name image_url price installments url store_id).each do |attribute|
    validates_presence_of attribute
  end

  validates_numericality_of :price
  validates_numericality_of :installments

  rails_admin do
    configure :store do
      label 'Store: '
    end
  end
end
