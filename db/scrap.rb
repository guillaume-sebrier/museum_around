require 'open-uri'
require 'nokogiri'
require 'ferrum'

def create_expos_from_html(html_doc)
  # mapping dates in French and regex to parse with Ruby
  month_map = {
    "janvier" => "january",
    "février" =>  "february",
    "mars"=>  "march",
    "avril"=>  "april",
    "mai"=>  "may",
    'juin'=>  "june",
    "juillet"=>  "july",
    "août" => "august",
    "septembre"=>  "september",
    "octobre"=> "october",
    "novembre"=>  "november",
    "décembre"=>  "december",
    "decembre"=>  "december"
  }
  re = Regexp.new(month_map.keys.map { |x| Regexp.escape(x) }.join('|'))

  html_doc.search('.Article-line').each do |element|
    photo = element.search('img').attribute('src').value
    title = element.search('h3').text.strip.gsub("\n","").gsub(/ +/," ").gsub("(reporté)", "").gsub("(événement suspendu)", "").gsub("(reportée)", "")
    date = element.search('.date').text.strip.gsub("\n","").gsub(/ +/," ")
    # Parsing starting and ending dates
    starting_date = date.match('(?<=du ).*(?= au)').to_s.gsub(re,month_map).to_date
    ending_date = date.match('(?<=au ).*').to_s.gsub(re,month_map).to_date
    # Getting place and adress string and separating in two strings
    placeaddress = element.search('.Article-line-place').text.strip.gsub("\n","").gsub(/ +/," ")
    place = placeaddress.match('.*(?= - )').to_s
    address = placeaddress.gsub(place,"").gsub(" - ","")
    description = element.search('.Article-line-content').text.strip.gsub("\n","").gsub(/ +/," ")
    site = Site.where("name ILIKE ?", place).first
    if site.nil?
      site = Site.create(name: place, address: address, picture: photo, description: description, fake: true)
      # site.geocode
      # site.save
    end
    puts "Creating #{title}"
    exhibition = Exhibition.create(title: title, description: description, site: site, place: place, address: address, photo: photo, date: date, starting_date: starting_date, ending_date: ending_date || (Time.now + 100000*(2..20).to_a.sample).to_date, category: Exhibition::CATEGORIES.sample, price: (7..14).to_a.sample*100)
    #creating fake review to populate database
    Review.create(rating: (2..5).to_a.sample, comment: ["Très belle expo", "Nous avons beaucoup aimé cette expo", "A refaire!", "Belle scénographie", "Très sympa", "GENIAL!!", "Bien sans plus"].sample, user: User.all.sample, exhibition: exhibition)
    sleep(1)
  end
end

def scrap_expos2 (url)
  #if open-uri does not work
  browser = Ferrum::Browser.new(timeout: 20)
  browser.goto(url)
  html = browser.body
  html_doc = Nokogiri::HTML(html)
  browser.quit
  create_expos_from_html(html_doc)
end

def scrap_expos (url)
  html = open(url).read
  html_doc = Nokogiri::HTML(html)
  create_expos_from_html(html_doc)
end
