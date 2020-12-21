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
    title = element.search('h3').text.strip.gsub("\n","").gsub(/ +/," ").gsub("(reporté)", "").gsub("(événement suspendu)", "").gsub("(reportée)", "").gsub("(réouverture le 15 décembre)", "")

    url = element.search('h3>a').attribute('href').value
    html_page = scrap_to_html ("https://www.parisinfo.com#{url}")
    detailed_desc = html_page.search('.ezxmltext-field').text.strip
    unless html_page.css('a:contains("Site Internet de l’événement")').attribute('href').nil?
      link = html_page.css('a:contains("Site Internet de l’événement")').attribute('href').value
    end
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
    old_exhib = Exhibition.where("title ILIKE ?", title).first
    unless old_exhib.nil?
      category = old_exhib.category
      longitude = old_exhib.longitude
      latitude = old_exhib.latitude
    end

    if site.nil?
      site = Site.create(name: place, address: address, picture: photo, description: description, fake: true)
      # site.geocode
      # site.save
    end
    puts "Creating #{title}"
    exhibition = Exhibition.create(title: title, description: description, site: site, place: place, address: address, photo: photo, date: date, starting_date: starting_date, ending_date: ending_date || (Time.now + 100000*(2..20).to_a.sample).to_date, category: category || 'Peinture', detailed_desc: detailed_desc, link:link, old: false, latitude: latitude, longitude: longitude)
    #creating fake review to populate database
    Review.create(rating: (2..5).to_a.sample, comment: ["Très belle expo", "Nous avons beaucoup aimé cette expo", "A refaire!", "Belle scénographie", "Très sympa", "GENIAL!!", "Bien sans plus"].sample, user: User.all.sample, exhibition: exhibition)
    sleep(1)
  end
end

def scrap_to_html (url)
  html = open(url).read
  html_doc = Nokogiri::HTML(html)
  return html_doc

  #uncomment if open-uri does not work
  # browser = Ferrum::Browser.new(timeout: 20)
  # browser.goto(url)
  # html = browser.body
  # html_doc = Nokogiri::HTML(html)
  # browser.quit
  # return html_doc
end
