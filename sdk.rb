require 'net/http'
require 'uri'
require 'json'

class AstrologyAPIClient
  
  @@baseURL = "https://json.astrologyapi.com/v1/"
  @@basePDFURL = "https://pdf.astrologyapi.com/v1/"
  
  def initialize(uid = nil, key = nil)
    @userID = uid
    @apiKey = key
  end
  
  def display
    {
      'userid' => @userID,
      'key' => @apiKey
    }
  end
  
  def getResponse(resource, data, headers = {}, apiType = nil)
    # Determine the base URL based on the apiType
    baseURL = apiType == "PDF" ? @@basePDFURL : @@baseURL
    
    # Create the full URL
    url = URI.parse(baseURL + resource)
    req = Net::HTTP::Post.new(url)
    req.basic_auth @userID, @apiKey
    req.set_form_data(data)

    # Add custom headers if provided
    headers.each do |key, value|
      req[key] = value
    end

    res = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(req)
    end

    if res.is_a?(Net::HTTPSuccess)
      # Parse and return the JSON response
      JSON.parse(res.body)
    else
      # Handle HTTP errors
      puts "HTTP Error: #{res.code} #{res.message}"
      puts "Response Body: #{res.body}"
      nil
    end
  rescue JSON::ParserError => e
    puts "Failed to parse JSON response: #{e.message}"
    nil
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    nil
  end


  # Custom API Call Method
  def customCall(endpoint, body = {}, additional_headers = {})
    # Merge any additional headers with required default headers
    default_headers = { "Content-Type" => "application/x-www-form-urlencoded" }
    headers = default_headers.merge(additional_headers)
    
    getResponse(endpoint, body, headers)
  end


  def customPDFCall(endpoint, body = {}, additional_headers = {})
    # Merge any additional headers with required default headers
    default_headers = { "Content-Type" => "application/x-www-form-urlencoded" }
    headers = default_headers.merge(additional_headers)
    
    getResponse(endpoint, body, headers,"PDF")
  end
  
  
  def packageHoroData(date, month, year, hour, minute, latitude, longitude, timezone)
    {
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
    {
      'day' => date,
      'month' => month,
      'year' => year,
      'name' => name
    }
  end
  
  def packageDailyHoroData(zodiacName, timezone)
    {
      'zodiacName' => zodiacName,
      'timezone' => timezone
    }
  end
  
  def packageMatchMakingData(maleBirthData, femaleBirthData)
    mData = {
      'm_day' => maleBirthData['date'],
      'm_month' => maleBirthData['month'],
      'm_year' => maleBirthData['year'],
      'm_hour' => maleBirthData['hour'],
      'm_min' => maleBirthData['minute'],
      'm_lat' => maleBirthData['latitude'],
      'm_lon' => maleBirthData['longitude'],
      'm_tzone' => maleBirthData['timezone']
    }
    
    fData = {
      'f_day' => femaleBirthData['date'],
      'f_month' => femaleBirthData['month'],
      'f_year' => femaleBirthData['year'],
      'f_hour' => femaleBirthData['hour'],
      'f_min' => femaleBirthData['minute'],
      'f_lat' => femaleBirthData['latitude'],
      'f_lon' => femaleBirthData['longitude'],
      'f_tzone' => femaleBirthData['timezone']
    }
    
    mData.merge(fData)
  end
  
  def call(resource, date, month, year, hour, minute, latitude, longitude, timezone)
    data = packageHoroData(date, month, year, hour, minute, latitude, longitude, timezone)
    getResponse(resource, data)
  end
  
  def matchMakingCall(resource, maleBirthData, femaleBirthData)
    data = packageMatchMakingData(maleBirthData, femaleBirthData)
    getResponse(resource, data)
  end
  
  def numeroCall(resource, date, month, year, name)
    data = packageNumeroData(date, month, year, name)
    getResponse(resource, data)
  end
  
  def dailyHoroCall(resource, zodiacName, timezone)
    data = packageDailyHoroData(zodiacName, timezone)
    getResponse(resource, data)
  end
end
