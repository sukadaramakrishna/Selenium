require 'capybara'

session=Capybara::Session.new(:selenium)
session.visit "https://tripsprint61-staging.socialmedialink.com/home"

if session.has_content?("Brand Name goes here")
puts "The page was rendered successfully"
else
puts "The page was not rendered"
exit(-1)
end