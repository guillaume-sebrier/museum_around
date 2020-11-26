require 'open-uri'
require 'nokogiri'
require 'ferrum'

def scrap_expos (url)
  browser = Ferrum::Browser.new
  browser.goto(url)
  html = browser.body
  html_doc = Nokogiri::HTML(html)
  browser.quit
  fake_site = Site.create(name: "fake")
  html_doc.search('.Article-line').each do |element|
    photo = element.search('img').attribute('src').value
    title = element.search('h3').text.strip.gsub("\n","").gsub(/ +/," ")
    date = element.search('.date').text.strip.gsub("\n","").gsub(/ +/," ")
    place = element.search('.Article-line-place').text.strip.gsub("\n","").gsub(/ +/," ")
    description = element.search('.Article-line-content').text.strip.gsub("\n","").gsub(/ +/," ")
    p Exhibition.create(title: title, description: description, site: fake_site, place: place, photo: photo, date: date )
  end
end

