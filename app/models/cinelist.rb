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

  def self.magic_times(object = nil)
    final_order = {}
    if object
      object.each do |film|
        unless film[1].blank?
          unless film[1][2].blank?
            final_order[film[0]] = []
            film[1][1].each do |film_time|
              time_start = Time.parse(film_time)
              time_end=time_start + film[1][2].to_i.minutes
              #final_order[film[0]] << {time_start: time_start.strftime("%H%M"), time_end: time_end.strftime("%H%M")}
              final_order[film[0]] << {time_start: time_start.strftime("%H%M"), time_end: time_end.strftime("%H%M"), name: film[1][0]}
              #puts film[0]
              #puts "#{{time_start: time_start, time_end: time_end, name:film[1][0]}}"
            end
          end
        end
      end
    end
    #final_order
    final_results = self.order_by_time(final_order)
    final_results
  end

  def self.order_by_time(final_order)
    #loop through each movie
    # sorted_movies1 = {}
    # movie_1 = {}
    combinations = []
    final_order.each do |film|
      #name of movie
      temp_name = film[1].first[:name]
      #loop through each time for movie
      film[1].each do |time_of_film|
        #excluding the current movie and same in other versions (2D/3D)
        movie =final_order.except(film[0]).delete_if { |k, v| v[0]==temp_name } unless final_order.blank?
        # get the movies that that start after the finish of the current time
        movie_1= movie.select { |k, v| v.first[:time_start].to_i> time_of_film[:time_end].to_i } unless movie.blank?
        #sort the result by the time in order to reduce the waiting time between movies
        sorted_movies1 = movie_1.sort { |a, b| a[1].first[:time_start] <=> b[1].first[:time_start] } unless movie_1.blank?
        #get the movie details ,etc
        unless sorted_movies1.blank?
          #preparation of result
          text_result = "<b>#{temp_name}</b> starting @#{time_of_film[:time_start]} and ends @#{time_of_film[:time_end]} ,then <b>#{sorted_movies1.first[1].first[:name]}</b> @#{sorted_movies1.first[1].first[:time_start]}"
          #keeping the 2nd film
          film2 = sorted_movies1.delete(sorted_movies1.first)
          # getting the 3rd back to back movie after the 2nd is removed form the list
          for_film3 = sorted_movies1.select { |k, v| v.first[:time_start].to_i> film2[1].first[:time_end].to_i }
          text_result << "<br>going for the 3rd... <b>#{for_film3.first[1].first[:name]}</b> @#{for_film3.first[1].first[:time_start]}" unless for_film3.blank?
          # similar to the 3rd movie, going for the 4th
          film3 = for_film3.delete(for_film3.first)
          for_film4 = for_film3.select { |k, v| v.first[:time_start].to_i> film3[1].first[:time_end].to_i }
          text_result << "<br>going for the achievement and the 4th...<b>#{for_film4.first[1].first[:name]}</b> @#{for_film4.first[1].first[:time_start]}" unless for_film4.blank?
          combinations << text_result
          #puts text_result
        end
        break
      end
    end
    combinations
  end


end