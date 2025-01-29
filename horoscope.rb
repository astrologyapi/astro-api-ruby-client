require './sdk'
require 'dotenv/load'


userID = ENV['ASTROLOGY_API_USER_ID']
apiKey = ENV['ASTROLOGY_API_KEY']

# Zodiac sign
zodiacName = "aries"
timezone = -5.5

# Daily Horoscope APIs need to be called
resource = "sun_sign_prediction/daily/"+zodiacName

# instantiate AstrologyAPIClient class
astrologyAPI = AstrologyAPIClient.new(userID, apiKey)

# call dailyHoroCall method for daily predictions
dailyHoroData = astrologyAPI.dailyHoroCall(resource,zodiacName,timezone)


# printing data
puts dailyHoroData