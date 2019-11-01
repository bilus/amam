require 'wombat'
require 'yaml'

class TKScraper
  include Wombat::Crawler
  base_url "https://www.tabelakalorii.net/"
  path "/"

  groups({css: ".calorie-group"}, :iterator) do
    title css: "h2"
    categories({css: ".calorie-group-items .row"}, :iterator) do
      title css: ".calorie-text h3"
      foods({css: "a.calorie-link"}, :follow) do
        title css: "h1.page-title"
        food({css: "tr.kt-row"}, :iterator) do
          name css: "td.food"
          serving css: "td.serving"
          kcal css: "td.kcal"
          kj css: "kj"
        end
      end
    end
  end
end

result = TKScraper.new.crawl
puts result.to_yaml
