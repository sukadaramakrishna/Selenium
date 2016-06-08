require 'capybara'
session = Capybara::Session.new(:selenium)
session.visit "http://www.amberbit.com"

if session.has_content?("We are programming for the Web")
  puts "All shiny, captain!"
else
  puts ":( no tagline fonud, possibly something's broken"
  exit(-1)
end