require "net/http"
class Cinelist < ActiveRecord::Base
  validates_presence_of :api_id
  validates_numericality_of :api_id
  attr_accessible :object_response, :name, :api_id

  def self.reach(api_type=nil, options={})
    case api_type
      when "c"
        link_type = "cinemas"
      when "f"
        link_type = "films"
      when "d"
        link_type = "dates="
      when "p"
        link_type = "performances"
      else
        link_type = nil
    end
    if link_type
      link = ENV["CINEWORLD_API_URL"]+link_type+"?key="+ENV["CINEWORLD_API_KEY"]
      link << "&cinema="+options[:cinema].to_s if options[:cinema]
      link << "&date="+options[:date].to_s if options[:date]
      link << "&film="+options[:film].to_s if options[:film]
      link << "&full=true" if api_type == "f"
      Rails.cache.fetch(link, expires_in: 23.hours) do
        uri = URI.parse(link)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        response.body[link_type]
        JSON.parse(response.body)[link_type]
      end
    else
      ""
    end
  end


  def self.duration(title=nil)
    puts title
    if title
      title = title[5..-1] if title[0..1]=="2D" or title[0..1]=="3D"
      #puts title
      link = ENV["IMDB_BY_TITLE"]+URI.encode(title)
      Rails.cache.fetch(link, expires_in: 23.hours) do
        uri = URI.parse(link)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        JSON.parse(response.body)["Runtime"]
      end
    else
      ""
    end
  end

  def self.t(string=nil)
    string.gsub(":", "").to_i unless string.blank?
  end

end
