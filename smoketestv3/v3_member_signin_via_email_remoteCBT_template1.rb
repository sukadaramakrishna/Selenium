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
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new

			caps["name"] = "Member Signin Via Email"
			caps["build"] = "1.0"
			caps["browser_api_name"] = "Chrome60x64"
			caps["os_api_name"] = "Win10"
			caps["screen_resolution"] = "1366x768"
			caps["record_video"] = "true"
			caps["record_network"] = "true"

			driver = Selenium::WebDriver.for(:remote,
			:url => "http://#{username}:#{authkey}@hub.crossbrowsertesting.com:80/wd/hub",
			:desired_capabilities => caps)

			session_id = driver.session_id

			score = "pass"
			cbt_api = CBT_API.new
			# maximize the window - DESKTOPS ONLY
			#driver.manage.window.maximize

			puts "Loading URL"
			driver.navigate.to(@base_url + "/home")
			#@driver.get(@base_url + "/home")
			# Click on Login button
			puts "Clicking Login button on the home page"
			driver.find_element(:xpath, "(//div[@class='welcome translucent'])[2]/div[2]/a[1]").click
			sleep(1)
			#Click on the email option
			puts "Clicking Email button on the Login modal"
			sleep(2)
			driver.find_element(:xpath, "//div[5]/div/div/div[2]/div/div/a[1]/div").click
			sleep(2)
			#Entering Username
			puts "Entering user name"
			sleep(1)
			driver.find_element(:xpath, "//div[@class='desktop-container ng-scope']/div/form/div[1]/input").click
			sleep(2)
			driver.find_element(:xpath, "//div[@class='desktop-container ng-scope']/div/form/div[1]/input").send_keys @config['member']['email']
			sleep(2)
			# then we'll enter the password
			puts "Entering password"
			sleep(1)
			driver.find_element(:xpath, "//div[@class='desktop-container ng-scope']/div/form/div[2]/input").click
			sleep(2)
			driver.find_element(:xpath, "//div[@class='desktop-container ng-scope']/div/form/div[2]/input").send_keys @config['member']['pass']
			sleep(2)
			# then we'll click the login button
			puts "Logging in"
			driver.find_element(:xpath, "//div[@class='desktop-container ng-scope']/div/form/button").click
			puts "logged in"

			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timeout => 10)
			wait.until {
				driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}

			# if we passed the login, then we should see some welcomeText
			welcomeText = driver.find_element(:xpath, "//div[@class='content-offer js-content-offer']/h1").text
			assert_equal("Offers for You", welcomeText)

			puts "Taking Snapshot"
			cbt_api.getSnapshot(session_id)
			cbt_api.setScore(session_id, "pass")

		rescue Exception => ex
		    puts ("#{ex.class}: #{ex.message}")
		    cbt_api.setScore(session_id, "fail")
		ensure     
		    driver.quit
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