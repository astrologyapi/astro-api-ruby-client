require 'net/http'
require 'uri'

class VRClient
  
  @@baseURL = "http://api.vedicrishiastro.com/v1/"
  def initialize(uid=nil,key=nil)
    @userID = uid
    @apiKey = key
  end
	
  def display()
		return {
			'userid' => @userID,
			'key' => @apiKey
		}
	end
	
  def getResponse(resource,data)
    url = URI.parse(@@baseURL+ resource)
    req = Net::HTTP::Post.new(url)
    req.basic_auth @userID, @apiKey
    req.set_form_data(data)
    resp = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    puts resp.body
  end
	  
  def packageHoroData(date, month, year, hour, minute, latitude, longitude, timezone)
    return {
      'day' => date,
      'month' => month,
      'year' => year,
      'hour' => hour,
      'min' => minute,
      'lat' => latitude,
      'lon' => longitude,
      'tzone' => timezone
    }
	end
	
	def packageNumeroData(date, month, year, name)
    return {
      'day' => date,
      'month' => month,
      'year' => year,
      'name' => name
    }
	end
	
	def packageMatchMakingData(maleBirthData, femaleBirthData)
		mData = {
      'm_day'=> maleBirthData['date'],
      'm_month'=> maleBirthData['month'],
      'm_year'=> maleBirthData['year'],
      'm_hour'=> maleBirthData['hour'],
      'm_min'=> maleBirthData['minute'],
      'm_lat'=> maleBirthData['latitude'],
      'm_lon'=> maleBirthData['longitude'],
      'm_tzone'=> maleBirthData['timezone']
		}
		
    fData = {
        'f_day'=> femaleBirthData['date'],
        'f_month'=> femaleBirthData['month'],
        'f_year'=> femaleBirthData['year'],
        'f_hour'=> femaleBirthData['hour'],
        'f_min'=> femaleBirthData['minute'],
        'f_lat'=> femaleBirthData['latitude'],
        'f_lon'=> femaleBirthData['longitude'],
        'f_tzone'=> femaleBirthData['timezone']
    }
		
		return mData.merge(fData)
	end
	
  def call(resource, date,month, year, hour, minute, latitude, longitude, timezone)
		data = self.packageHoroData(date, month, year, hour, minute, latitude, longitude, timezone)
		getResponse(resource,data)
	end
	
	def matchMakingCall(resource, maleBirthData, femaleBirthData)
		data = self.packageMatchMakingData(maleBirthData, femaleBirthData)
		getResponse(resource,data)
	end
	
	def numeroCall(resource, date, month, year, name)
		data = self.packageNumeroData(date, month, year, name)
		getResponse(resource,data)
	end
end

