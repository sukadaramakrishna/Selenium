require 'capybara'
require 'capybara/rspec'
 
session=Capybara::Session.new(:selenium)
session.visit "https://tripsprint62-staging.socialmedialink.com/home"


fill_in "member_email", :with => "john.snow@yopmail.com"
fill_in "member_password", :with => "12345678"
click(:xpath, '//input[@name="commit"]').click