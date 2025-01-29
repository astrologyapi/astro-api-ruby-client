require './sdk'
require 'dotenv/load'


userID = ENV['ASTROLOGY_API_USER_ID']
apiKey = ENV['ASTROLOGY_API_KEY']

dateOfBirth = 25
monthOfBirth = 12
yearOfBirth = 1988
name = 'Your Name'

# Numerology APIs which needs to be called
resource = 'numero_table'

# instantiate AstrologyAPIClient class
astrologyAPI = AstrologyAPIClient.new(userID, apiKey)

# call numerology method of the AstrologyAPIClient
numeroData = astrologyAPI.numeroCall(resource, dateOfBirth, monthOfBirth, yearOfBirth, name);

# printing data
puts numeroData