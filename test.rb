require './sdk'
require 'dotenv/load'


userID = ENV['ASTROLOGY_API_USER_ID']
apiKey = ENV['ASTROLOGY_API_KEY']

# Replace with your actual User ID and API Key
if userID == "<YourUserIdhere>" || apiKey == "<YourApiKeyHere>"
  puts "Please replace <YourUserIdhere> and <YourApiKeyHere> with your actual credentials in test.rb"
  exit
end

# Dummy data to call AstrologyAPI
data = {
  'date' => 10,
  'month' => 12,
  'year' => 1993,
  'hour' => 1,
  'minute' => 25,
  'latitude' => 25,
  'longitude' => 82,
  'timezone' => 5.5
}

# API endpoint to be called
resource = "astro_details"

# Instantiate AstrologyAPIClient class
astrologyAPI = AstrologyAPIClient.new(userID, apiKey)

# Call horoscope API
responseData = astrologyAPI.call(
  resource,
  data['date'],
  data['month'],
  data['year'],
  data['hour'],
  data['minute'],
  data['latitude'],
  data['longitude'],
  data['timezone']
)

# Check and print response data
if responseData
  puts "API Response:"
  puts responseData
else
  puts "Failed to retrieve data from the API."
end
