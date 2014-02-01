class HomeController < ApplicationController
  def index
    @users = User.all
    @cinemas = Cinelist.select("api_id, name")
  end

  def films
    @date = params[:cinelist][:date].try(:gsub, "/", "")
    @cinema = params[:cinelist][:cinema_id]
    opts = {cinema: params[:cinelist][:cinema_id], date: @date}
    @films = Cinelist.reach("f", opts)
  end

  def film_results

    # at this point , I have the edi, title, date,time and need to check
    puts params
    static_opts = {cinema: params[:movies][:cinema_id], date: params[:movies][:date]}
    @film_times = {}
    params[:movies][:results].each_pair do |movie_edi, movie_title|
      static_opts[:film]=movie_edi
      temp_times = Cinelist.reach("p", static_opts)
      temp_times.select! { |perf| perf["available"] == true && Cinelist.t(perf["time"])>=Cinelist.t(params[:movies][:time]) }
      @film_times[movie_edi] = [movie_title.try(:first), temp_times.collect { |perf| perf["time"] }, Cinelist.duration(movie_title.try(:first))]
    end
    #example output
    #"movies"=>{"date"=>"20140201", "time"=>"19:40", "results"=>{"144628"=>["The Wolf of Wall Street"], "109377"=>["12 Years A Slave"], "61662"=>["2D - I, Frankenstein"]}}
  end
end
