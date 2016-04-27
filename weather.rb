require 'forecast_io'
require 'openssl'
require 'open-uri'
require 'csv'
require 'JSON'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
ForecastIO.api_key = '55017c0ce854ceab1db44c34d7bb07d5'

class Weatherman
  attr_reader :lat, :lng

  def self.forecast(zip)
    lat = zip_to_geo(zip)[0]
    lng = zip_to_geo(zip)[1]

    ForecastIO.forecast(lat, lng).currently["temperature"]
  end

  private

  def self.zip_to_geo(zip)
    geocode = open('https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:' + zip + '&key=AIzaSyDFHNQdZBFKEU2NSpCEeTHbu-TdgUZOa-8').read
    JSON.parse(geocode)["results"][0]["geometry"]["location"].values
  end
end

puts Weatherman.forecast("10038")

