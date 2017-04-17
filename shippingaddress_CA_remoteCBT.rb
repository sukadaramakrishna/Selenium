# Getting started: http://docs.seleniumhq.org/docs/03_webdriver.jsp
# API details: https://github.com/SeleniumHQ/selenium#selenium

# The gem "Rest-CLient" is highly recommended for making API calls
# install it with "gem install rest-client"

# For creating unit tests, we recommend test-unit
# Install it with "gem install test-unit"

require "selenium-webdriver"
require "rest-client"
require "test-unit"
require "yaml" 

class LoginFormTest < Test::Unit::TestCase
	def test_login_form_test
		begin
			@config = YAML.load_file("config_smiley.yml")
			@base_member_url = @config['member']['base_url']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new
			#caps['selenium-version'] = "2.53.4"
			caps["name"] = "ShippingAddress update CA"
			caps["build"] = "1.0"
			caps["browser_api_name"] = "FF46x64"
            caps["os_api_name"] = "Win8.1"
			caps["screen_resolution"] = "1920x1080"
			caps["record_video"] = "true"
			caps["record_network"] = "true"

			
			@driver = Selenium::WebDriver.for(:remote,
			:url => "http://#{username}:#{authkey}@hub.crossbrowsertesting.com:80/wd/hub",
			:desired_capabilities => caps)

			session_id = @driver.session_id
			
			 @driver.file_detector = lambda do |args|
			# args => ["/path/to/file"]
			str = args.first.to_s    
			str if File.exist?(str)
	   end
			score = "pass"
			cbt_api = CBT_API.new
			# maximize the window - DESKTOPS ONLY
			@driver.manage.window.maximize

			puts "Loading URL"
			@driver.navigate.to(@config['member']['base_url']	+ "/home")
			# start login process by entering username
			puts "Entering username"
			@driver.find_element(:id, "member_email").send_keys @config['member']['email']

			# then we'll enter the password
			puts "Entering password"
			@driver.find_element(:id, "member_password").send_keys @config['member']['pass']

			# then we'll click the login button
			puts "Logging in"
			@driver.find_element(:name, "commit").click
			
			#Update shiping address
			puts "Updating shipping address.."
			@driver.find_element(:xpath, "//span[@class='header-user-name']").click
	sleep(1)

    @driver.find_element(:link, "Shipping Address").click
	sleep(1)
	Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "member_country")).select_by(:text, "Canada")
	sleep(1)
    @driver.find_element(:id, "member_address_2").clear
    @driver.find_element(:id, "member_address_2").send_keys @config['signup']['address1_CA']
	sleep(1)
    @driver.find_element(:id, "member_address_1").clear
    @driver.find_element(:id, "member_address_1").send_keys @config['signup']['address2']
	sleep(1)
	Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "member_state")).select_by(:text, @config['signup']['state_CA'])
	sleep(1)
    @driver.find_element(:id, "member_city").clear
    @driver.find_element(:id, "member_city").send_keys @config['signup']['city_CA']
	sleep(1)
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @config['signup']['zip_CA']
	sleep(1)
    @driver.find_element(:xpath, "//input[@value='Save Shipping Address']").click
	sleep(2)
	puts "shipping address updated"
			
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = @driver.find_element(:xpath, "//div[@class='profile-register-title']/h1").text
			assert_equal("Profile", welcomeText)

			puts "Taking Snapshot"
			cbt_api.getSnapshot(session_id)
			cbt_api.setScore(session_id, "pass")

		rescue Exception => ex
		    puts ("#{ex.class}: #{ex.message}")
		    cbt_api.setScore(session_id, "fail")
		ensure     
		    @driver.quit
		end
	end
end

class CBT_API
	@@username = 'tripthi.shetty%40socialmedialink.com'
	@@authkey = 'u283c7d7d4fafeb7'
	@@BaseUrl =   "https://#{@@username}:#{@@authkey}@crossbrowsertesting.com/api/v3"
	def getSnapshot(sessionId)
	    # this returns the the snapshot's "hash" which is used in the
	    # setDescription function
	    response = RestClient.post(@@BaseUrl + "/selenium/#{sessionId}/snapshots",
	        "selenium_test_id=#{sessionId}")
	    snapshotHash = /(?<="hash": ")((\w|\d)*)/.match(response)[0]
	    return snapshotHash
	end

	def setDescription(sessionId, snapshotHash, description)
	    response = RestClient.put(@@BaseUrl + "/selenium/#{sessionId}/snapshots/#{snapshotHash}",
	        "description=#{description}")
	end

	def setScore(sessionId, score)
	    # valid scores are 'pass', 'fail', and 'unset'
	    response = RestClient.put(@@BaseUrl + "/selenium/#{sessionId}",
	        "action=set_score&score=#{score}")
	end
end