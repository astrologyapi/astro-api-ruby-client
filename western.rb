require './sdk'
require 'dotenv/load'


userID = ENV['ASTROLOGY_API_USER_ID']
apiKey = ENV['ASTROLOGY_API_KEY']

# Instantiate the client
astrologyAPI = AstrologyAPIClient.new(userID, apiKey)

# Endpoint and data for the natal wheel chart API
endpoint = "natal_wheel_chart"
data = {
   'day' => 10,
  'month' => 12,
  'year' => 1993,
  'hour' => 1,
  'min' => 25,
  'lat' => 25,
  'lon' => 82,
  'tzone' => 5.5
}


# Make the custom API call
response = astrologyAPI.customCall(endpoint, data)

# Print the response
if response
  puts "API Response:"
  puts JSON.pretty_generate(response)
else
  puts "Failed to retrieve data from the API."
end