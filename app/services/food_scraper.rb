# Scrapes website to populate the `foods` table
class FoodScraper
  def call
    Food.transaction do
      scrape_tk.each(&:save!)
    end
  end

  protected

  # Scrape tabelakalorii.net
  def scrape_tk
    groups = TKScraper.new.scrape['groups']
    groups.flat_map do |group|
      categories = group["categories"]
      categories.flat_map do |category|
        category['details'].flat_map do |details|
          details['foods'].map do |food|
            Food.new(
              name: food['name'],
              serving: food['serving']&.to_i,
              kcal: food['kcal']&.to_i,
              kj: food['kj']&.to_i,
              group: group['title'],
              category: category['title'],
            )
          end
        end
      end
    end
  end
end

class TKScraper
  include Wombat::Crawler
  base_url 'https://www.tabelakalorii.net/'
  path '/'

  groups({css: '.calorie-group'}, :iterator) do
    title css: 'h2'
    categories({css: '.calorie-group-items .row'}, :iterator) do
      title css: '.calorie-text h3'
      details({css: 'a.calorie-link'}, :follow) do
        foods({css: 'tr.kt-row'}, :iterator) do
          name css: 'td.food'
          serving css: 'td.serving'
          kcal css: 'td.kcal'
          kj css: 'kj'
        end
      end
    end
  end
end
