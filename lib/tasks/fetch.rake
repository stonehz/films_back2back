namespace :fetch do

  desc "cinema_list"

  task :cinemas => :environment do
    begin
      cinemas = Cinelist.reach("c")
        cinemas.each do |cinema|
          puts "creating cinema #{cinema["name"]}"
          Cinelist.find_or_create_by_api_id api_id: cinema["id"], name: cinema["name"]

        end
    rescue Exception => ex
      Logger.new("#{Rails.root}/log/fetcher.log").info "#{Time.now} : error occurred trying to get info:  #{ex.message}"
    end
  end

end