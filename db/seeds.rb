require 'json'
require 'open-uri'
require 'digest'
require 'nokogiri'
require 'ferrum'
require_relative 'scrap'

# Friendship.destroy_all
# User.destroy_all

# osm_url = "https://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A%E2%80%9Ctourism%3Dmuseum%20in%20ile-de-france%20%E2%80%9D%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A25%5D%3B%0A%2F%2F%20fetch%20area%20%E2%80%9Cile-de-france%E2%80%9D%20to%20search%20in%0Aarea%283600008649%29-%3E.searchArea%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20%2F%2F%20query%20part%20for%3A%20%E2%80%9Ctourism%3Dmuseum%E2%80%9D%0A%20%20node%5B%22tourism%22%3D%22museum%22%5D%28area.searchArea%29%3B%0A%20%20way%5B%22tourism%22%3D%22museum%22%5D%28area.searchArea%29%3B%0A%20%20relation%5B%22tourism%22%3D%22museum%22%5D%28area.searchArea%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%3B%0A%3E%3B%0Aout%20skel%20qt%3B"

# puts "Destroy Sites, Exhibitions and bookings"
# Booking.destroy_all
# Site.destroy_all
# Exhibition.destroy_all

# puts "Parse sites from JSON"

# hours_map = {
#   "Mo" => "Lu",
#   "Tu" =>  "Ma",
#   "We"=>  "Me",
#   "Th"=>  "Je",
#   "Fr"=>  "Ve",
#   'Sa'=>  "Sa",
#   "Su"=>  "Di",
#   "May" => "Mai",
#   "Aug"=>  "Aou",
#   "Feb"=> "Fev",
#   "Apr"=>  "Avr",
#   "Jun"=>  "Juin",
#   "Jul"=>  "Juil",
#   "off"=> "fermé",
#   'easter' => 'Pâques'
# }
# reg = Regexp.new(hours_map.keys.map { |x| Regexp.escape(x) }.join('|'))


# museums = JSON.parse(open(osm_url).read)

# museums['elements'].each do |site|
#   if site['tags'].present? && site['tags']['name'].present?
#   latitude = site['lat']
#   longitude = site['lon']
#     name = site['tags']['name']
#     puts "Creating #{name}"
#     opening_hours = site['tags']['opening_hours'].gsub(";","<br>").gsub(reg,hours_map) if site['tags']['opening_hours'].present?
#     address = "#{site['tags']["addr:housenumber"]} #{site['tags']["addr:street"]} #{site['tags']["addr:postcode"]} #{site['tags']["addr:city"]}"
#     description = site['tags']['description']
#     phone = site['tags']['phone']
#     website = site['tags']['website']
#     wikidata = site['tags']['wikidata']
#     wikipedia = site['tags']['wikipedia']
#     if !wikidata.nil?
#       wikidata_url = "https://www.wikidata.org/wiki/Special:EntityData/#{wikidata}.json"
#       wikidata_data = JSON.parse(open(wikidata_url).read)
#       if !wikidata_data["entities"][wikidata].nil?
#         if !wikidata_data["entities"][wikidata]["claims"]["P18"].nil?
#           photo_name = wikidata_data["entities"][wikidata]["claims"]["P18"][0]["mainsnak"]["datavalue"]["value"].gsub(" ", "_")
#           md5 = Digest::MD5.hexdigest(photo_name)
#           picture_link = "https://upload.wikimedia.org/wikipedia/commons/#{md5[0]}/#{md5[0]}#{md5[1]}/#{photo_name}"
#         end
#       end
#     end
#     if !wikipedia.nil?
#       wiki_link = "https://fr.wikipedia.org/wiki/#{wikipedia}"
#       # wiki_shortname = wikipedia[3..]
#       # wiki_desc_url = "https://fr.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{wiki_shortname}"
#       # wikipedia_data = JSON.parse(open(wiki_desc_url).read)
#       # wiki_extract = wikipedia_data['query']['pages'].first["extract"]
#     end
#   new_site = Site.new(name: name, latitude: latitude, longitude: longitude, opening_time: opening_hours, address: address, picture: picture_link, website: website, wiki_link: wiki_link, phone: phone, description: description, price: (7..14).to_a.sample*100)
#   new_site.save!
#   end
# end



url1 = "https://www.parisinfo.com/ou-sortir-a-paris/infos/guides/calendrier-expositions-paris?perPage=50"
url2 = "https://www.parisinfo.com/ou-sortir-a-paris/infos/guides/calendrier-expositions-paris?perPage=50&page=2"
create_expos_from_html scrap_to_html_2 url1
create_expos_from_html scrap_to_html_2 url2

puts "Finished"


