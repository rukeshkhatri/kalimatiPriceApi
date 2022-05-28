require "open-uri"
require "nokogiri"
require "json"

def today_price
  url = "https://kalimatimarket.gov.np/lang/en"
  html = URI.open(url)

  doc = Nokogiri::HTML(html)
  items = []
  table = doc.at("table")

  table.search("tr").each do |tr|
    cells = tr.search("td")
    unless cells[0].nil?
      items.push(
        name: cells[0].text,
        unit: cells[1].text,
        min_price: cells[2].text,
        max_price: cells[3].text,
        avg_price: cells[4].text,
      )
    end
  end

  render :json => items
end

# define a suitable route for this and it should return the data in JSON.
