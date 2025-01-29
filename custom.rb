require './sdk'
require 'dotenv/load'


userID = ENV['ASTROLOGY_API_USER_ID']
apiKey = ENV['ASTROLOGY_API_KEY']

# Instantiate the client
astrologyAPI = AstrologyAPIClient.new(userID, apiKey)

# Endpoint and data for the API
endpoint = "sun_sign_prediction/daily/aries"
data = {
  'tzone' => 5.5
}

# Additional headers
headers = { "language" => "en" }

# Make the custom API call
response = astrologyAPI.customCall(endpoint, data, headers)

# Print the response
if response
  puts "API Response:"
  puts JSON.pretty_generate(response)
else
  puts "Failed to retrieve data from the API."
end

#Endpoint and data for the PDF API
pdfEndpoint = 'basic_horoscope_pdf'
pdfReqData = {
    'name' =>"Lokesh Kumar",
    'gender' =>  "male",
    'day' => 8,
    'month' =>  8,
    'year' => 1996,
    'hour' => 15,
    'minute' => 46,
    'latitude' => 25.5940947,
    'longitude'=> 85.13756450000005,
    'place' => "Patna, Bihar",
    'tzone' => 5.5
  }

  # Make the custom API call
pdfResponse = astrologyAPI.customPDFCall(pdfEndpoint, pdfReqData)

# Print the response
if pdfResponse
  puts "API Response:"
  puts JSON.pretty_generate(pdfResponse)
else
  puts "Failed to retrieve data from the API."
end