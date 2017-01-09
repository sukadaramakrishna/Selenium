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
			@base_url = @config['member']['base_url']
			@first_name = @config['signup']['first_name']
			@last_name = @config['signup']['last_name']
			@email = @config['signup']['email_twitter']
			@pass = @config['signup']['pass_twitter']
			@zip = @config['signup']['zip']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new

			caps["name"] = "Member Signup Via Twitter"
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

			score = "pass"
			cbt_api = CBT_API.new
			# maximize the window - DESKTOPS ONLY
			@driver.manage.window.maximize

			puts "Loading URL"
			@driver.navigate.to(@base_url + "/home")
			#@driver.get(@base_url + "/home")
			
			puts "Sign up via Twitter"
			@driver.find_element(:css, "a.login-connect-twitter").click
    sleep(2)
	puts "Entering TW email"
    @driver.find_element(:id, "username_or_email").clear
    @driver.find_element(:id, "username_or_email").send_keys @email
    sleep(2)
	puts "Entering TW password"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys @pass
    sleep(1)
	puts "Clicking the login button"
    @driver.find_element(:id, "allow").click
	sleep(3)
	puts "Entering email"
	@driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @email
	puts "Entering last name"
    @driver.find_element(:id, "member_last_name").clear
    @driver.find_element(:id, "member_last_name").send_keys @last_name
	puts "Entering Zipcode"
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @zip
	puts "Entering DOB"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_month")).select_by(:text, "September")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_day")).select_by(:text, "15")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_year")).select_by(:text, "1987")
	puts "Entering gender"
    @driver.find_element(:css, "label.control-radio").click
	puts "Submitting"
    @driver.find_element(:name, "commit").click
	sleep(2)
	@driver.find_element(:css, "a.btn.btn-color.btn-lg").click
	sleep(2)
	puts "Successfuly signed up via Twitter"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "(//div[@class='tour-navigation'])[1]/div[1]/button").text
			assert_equal("", welcomeText)

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