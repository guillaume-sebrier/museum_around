require 'open-uri'
require 'nokogiri'
require 'ferrum'

def scrap_expos_v2 (url)
  browser = Ferrum::Browser.new
  browser.goto(url)
  html = browser.body
  html_doc = Nokogiri::HTML(html)
  browser.quit
  html_doc.search('.Article-line').each do |element|
    photo = element.search('img').attribute('src').value
    title = element.search('h3').text.strip.gsub("\n","").gsub(/ +/," ").gsub("(reporté)", "").gsub("(événement suspendu)", "").gsub("(reportée)", "")
    date = element.search('.date').text.strip.gsub("\n","").gsub(/ +/," ")
    place = element.search('.Article-line-place').text.strip.gsub("\n","").gsub(/ +/," ")
    description = element.search('.Article-line-content').text.strip.gsub("\n","").gsub(/ +/," ")
    puts "Creating #{title}"
    exhibition = Exhibition.create(title: title, description: description, site: Site.all.sample, place: place, photo: photo, date: date, category: Exhibition::CATEGORIES.sample, price: 123, ending_date: (Time.now + 400000).to_date)
    Review.create(rating: (1..5).to_a.sample, comment: Faker::Restaurant.review, user: User.all.sample, exhibition: exhibition)
  end
end
