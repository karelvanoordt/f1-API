require 'httparty'
require 'nokogiri'
require 'byebug'

def f1_2002_standings_pilots

    url = 'https://www.espn.com/f1/standings'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)

    unparsed_pilots = parsed_page.css('tr.Table__TR')
    pilots = Array.new

    unparsed_pilots.each do |pilot|

        
            
        pilot = {
            position: pilot.css('span.team-position').text.strip,
            name: pilot.css('span.hide-mobile').text,
            abbr: pilot.css('span.show-mobile').text,
            nationality: pilot.css('img.Image').attr('alt'),
            points: pilot.css('span.stat-cell').text, 
            team: ""
        }

        case pilot[:name]
        when  'Max Verstappen', 'Sergio Perez'
            pilot[:team] = 'Red Bull'
        when 'George Russell', 'Lewis Hamilton'
            pilot[:team] = 'Mercedes'
        when 'Carlos Sainz', 'Charles Leclerc'
            pilot[:team] = 'Ferrari'
        when 'Lando Norris', 'Daniel Ricciardo'
            pilot[:team] = 'McLaren'
        when 'Fernando Alonso', 'Esteban Ocon'
            pilot[:team] = 'Alpine'
        when 'Pierre Gasly', 'Yuki Tsunoda'
            pilot[:team] = 'Alphatauri'
        when 'Valtteri Bottas', 'Guanyu Zhou'
            pilot[:team] = 'Alfa Romeo'
        when 'Sebastian Vettel', 'Lance Stroll', 'Nico Hulkenberg'
            pilot[:team] = 'Aston Martin'
        when 'Alexander Albon', 'Nicholas Latifi'
            pilot[:team] = 'Williams'
        when 'Mick Schumacher', 'Kevin Magnussen'
            pilot[:team] = 'Haas'
    end

        unless pilot[:position] == ""
            pilots << pilot

            puts ""
            puts "Pos: #{pilot[:position]}"
            puts "Name: #{pilot[:name]}"
            puts "Team: #{pilot[:team]}"
            puts "Nationality: #{pilot[:nationality]}"
            puts "Points: #{pilot[:points]}"
        end

    end
end

f1_2002_standings_pilots