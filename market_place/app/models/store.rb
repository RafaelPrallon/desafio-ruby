class Store
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  field :name,               type: String
  field :website,            type: String
  ## Database authenticatable
  field :email,              type: String
  field :encrypted_password, type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  %i(name website email encrypted_password).each do |attribute|
    validates_presence_of attribute
  end

  has_many :products

  def add_products
    self.import_products(0, 49)
    self.import_products(50, 99)
  end

  def import_products(start_from, end_at)
    request_url = self.website + "/api/catalog_system/pub/products/search?_from=#{start_from}&_to=#{end_at}"
    response = RestClient.get request_url
    list_of_products = JSON.parse(response.body)
    unless list_of_products.nil?
      puts 'pegou o json com sucesso'
    end

    list_of_products.each do |product_json|
      image_url = product_json["items"].first["images"].first["imageUrl"]
      product_url = product_json["link"]
      commertial_offer = product_json["items"].first["sellers"].first["commertialOffer"]
      number_of_installments = commertial_offer["Installments"].max_by{|x| x["NumberOfInstallments"]}["NumberOfInstallments"]
      product_name = product_json["productName"]
      price = commertial_offer["Price"]

      product = Product.new(
        name: product_name,
        url: product_url,
        image_url: image_url,
        price: price,
        installments: number_of_installments,
        store: self
      )

      if product.save
        puts "O produto #{product_name} foi adicionado com sucesso"
      else
        puts product.errors.full_messages
        break
      end
    end
  end
end
