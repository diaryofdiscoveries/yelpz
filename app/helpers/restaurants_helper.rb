module RestaurantsHelper
  Rails.application.secrets.google_api_key
  def stringify(name, address)
    (name.to_s + " " + address.to_s).split(" ").join("%20")
  end
end
