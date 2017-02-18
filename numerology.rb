require './sdk'


userID = "<YourUserIdhere>"
apiKey = "<YourApiKeyHere>"

dateOfBirth = 25
monthOfBirth = 12
yearOfBirth = 1988
name = 'Your Name'

# Numerology APIs which needs to be called
resource = 'numero_table'

# instantiate VRClient class
vedicRishi = VRClient.new(userID, apiKey)

# call numerology method of the VRClient
numeroData = vedicRishi.numeroCall(resource, dateOfBirth, monthOfBirth, yearOfBirth, name);

# printing data
puts numeroData