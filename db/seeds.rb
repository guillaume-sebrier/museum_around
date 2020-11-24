require 'json'
require 'open-uri'
require 'nokogiri'


url = "https://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A%E2%80%9Ctourism%3Dmuseum%20in%20ile-de-france%20%E2%80%9D%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A25%5D%3B%0A%2F%2F%20fetch%20area%20%E2%80%9Cile-de-france%E2%80%9D%20to%20search%20in%0Aarea%283600008649%29-%3E.searchArea%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20%2F%2F%20query%20part%20for%3A%20%E2%80%9Ctourism%3Dmuseum%E2%80%9D%0A%20%20node%5B%22tourism%22%3D%22museum%22%5D%28area.searchArea%29%3B%0A%20%20way%5B%22tourism%22%3D%22museum%22%5D%28area.searchArea%29%3B%0A%20%20relation%5B%22tourism%22%3D%22museum%22%5D%28area.searchArea%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%3B%0A%3E%3B%0Aout%20skel%20qt%3B"

Site.destroy_all
Exhibition.destroy_all
puts "Destroy Sites & Exhibitions"

museums = JSON.parse(open(url).read)

museums['elements'].first(2).each do |site|
  latitude = site['lat']
  longitude = site['lon']
  name = site['tags']['name']
  opening_hours = site['tags']['opening_hours']
  address = "#{site['tags']["addr:housenumber"]} #{site['tags']["addr:street"]}, #{site['tags']["addr:postcode"]} #{site['tags']["addr:city"]}"
  website = site['tags']['website']
  wikidata = site['tags']['wikidata']
  if !wikidata.nil?
    wikidata_url = "https://www.wikidata.org/wiki/Special:EntityData/#{wikidata}.json"
    wikidata_data = JSON.parse(open(wikidata_url).read)
    photo_name = wikidata_data["entities"][wikidata]["claims"]["P18"][0]["mainsnak"]["datavalue"]["value"]
    photo_link = "https://commons.wikimedia.org/wiki/File:#{photo_name}".gsub(" ", "_").encode('ASCII')
    html_doc = Nokogiri::HTML(open(photo_link).read)
    link = html_doc.search('img').attribute('src').value
  end
  new_site = Site.new(name: name, latitude: latitude, longitude: longitude, opening_time: opening_hours, address: address, picture: link)
  new_site.save!
end


# puts "Parse sites from JSON"

# (1..10).each do |i|
#   new_exhibition = Exhibition.new(title: "exhibition #{i}", site: Site.all.sample)
#   new_exhibition.save!
# end
puts "Create exhibitions"




