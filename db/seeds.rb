require 'json'
require 'open-uri'

url = "http://api.opentripmap.com/0.1/en/places/bbox?lon_min=2.3&lat_min=48.7&lon_max=2.4&lat_max=48.9&kinds=museums&apikey=5ae2e3f221c38a28845f05b6563827e5a50a0e91c147a040535547da"
Site.destroy_all
Exhibition.destroy_all
puts "Destroy Sites & Exhibitions"

museums = JSON.parse(open(url).read)

museums['features'].each do |site|
  name = site['properties']['name']
  latitude = site['geometry']['coordinates'][1]
  longitude = site['geometry']['coordinates'][0]
  new_site = Site.new(name: name, latitude: latitude, longitude: longitude)
  new_site.save!
end
puts "Parse sites from JSON"

(1..10).each do |i|
  new_exhibition = Exhibition.new(title: "exhibition #{i}", site: Site.all[i])
  new_exhibition.save!
end
puts "Create exhibitions"


# p url_node = "https://www.openstreetmap.org/api/0.6/#{osm_node}.json"

#   wikidata = museums['features'][0]['properties']['wikidata']
#   osm_node = museums['features'][0]['properties']['osm']

