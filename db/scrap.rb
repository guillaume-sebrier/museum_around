require 'open-uri'
require 'nokogiri'

def scrap_expos
  url = "https://www.parisinfo.com/ou-sortir-a-paris/infos/guides/calendrier-expositions-paris?perPage=50"
  fake_site = Site.new(name: "fake")
  html_doc = Nokogiri::HTML(open(url).read)
  html_doc.search('.Article-line').each do |element|
    p photo = element.search('img').attribute('src').value
    p title = element.search('h3').text.strip
    p date = element.search('.date').text.strip
    p place = element.search('.Article-line-place').text.strip
    p description = element.search('.Article-line-content').text.strip
    Exhibition.new(title: title, description: description, site: fake_site )
  end
end

scrap_expos
