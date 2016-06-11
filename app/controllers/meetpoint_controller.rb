require 'open-uri'

class MeetpointController < ApplicationController

  def enter_addresses
    # Nothing to do here.
    render("enter_addresses.html.erb")
  end

  def your_meetpoint
    @address_1 = params[:user_address_1]
    url_safe_address_1 = URI.encode(@address_1)
    url_geo = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_address_1
    parsed_data_geo_1 = JSON.parse(open(url_geo).read)
    @latitude_1 = parsed_data_geo_1["results"][0]["geometry"]["location"]["lat"]
    @longitude_1 = parsed_data_geo_1["results"][0]["geometry"]["location"]["lng"]


    @address_2 = params[:user_address_2]
    url_safe_address_2 = URI.encode(@address_2)
    url_geo = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_address_2
    parsed_data_geo_2 = JSON.parse(open(url_geo).read)
    @latitude_2 = parsed_data_geo_2["results"][0]["geometry"]["location"]["lat"]
    @longitude_2 = parsed_data_geo_2["results"][0]["geometry"]["location"]["lng"]


    @mid_latitude = (@latitude_1 + @latitude_2)/2
    @mid_longitude = (@longitude_1 + @longitude_2)/2

    params = { term: 'food', limit: 5}
    coordinates = {latitude: @mid_latitude, longitude: @mid_longitude}

    @yelp_biz = Yelp.client.search_by_coordinates(coordinates, params).businesses


    render("your_meetpoint.html.erb")
  end
end
