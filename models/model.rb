require 'uri'
require 'net/http'
require 'json'
require 'pry'


def make_api_call(request_string)
    uri = URI(request_string) #open portal for app
    response = Net::HTTP.get(uri) #go get data
    formatted_data = JSON.parse(response) #turn data into something our app understands - a hash
    asteroid_data = []
    # formatted_data["element_count"]
    formatted_data["near_earth_objects"]["#{params[:date]}"].each do |asteroid|
        asteroid_hash = {}
        asteroid_hash[:name] = asteroid["name"]
        asteroid_hash[:diameter] = (asteroid["estimated_diameter"]["feet"]["estimated_diameter_min"] + asteroid["estimated_diameter"]["feet"]["estimated_diameter_max"])/2
        asteroid_hash[:miss_distance] = asteroid["close_approach_data"][0]["miss_distance"]["miles"]
        asteroid_hash[:velocity] = asteroid["close_approach_data"][0]["relative_velocity"]["miles_per_hour"]
        asteroid_data << asteroid_hash
    end
   
    return asteroid_data
end

def format_request_and_send_api_call(date)
    neo_request = "https://api.nasa.gov/neo/rest/v1/feed?start_date=#{date}&end_date=#{date}&api_key=tLvjxkTMDJImr4St0luRQZUDsQ0FkYi7oFxPDRkZ"
    make_api_call(neo_request)
end

#date must be formatted as YYYY-MM-DD

#{search_term.gsub(" ","+")}

# 5w4tEgqc5u894hUVDmigLZdfB81YhkGD3omkuRGf