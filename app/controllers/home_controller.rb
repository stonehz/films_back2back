class HomeController < ApplicationController
  def index
    @users = User.all
    @cinemas = Cinelist.reach("c")
  end

  def films
    @date = params[:cinelist][:date].try(:gsub, "/", "")
    opts = {cinema: params[:cinelist][:cinema_id], date: @date}
    @films = Cinelist.reach("f", opts)
  end

  def film_results

    # at this point , I have the edi, title, date,time and need to check
    puts params
  end
end
