namespace :seed do
  desc "Seed foods table"
  task foods: :environment do
    Food.transaction do
      puts "Deleting existing records..."
      Food.delete_all
      puts "Scraping foods..."
      FoodScraper.new.call
    end
  end
end
