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
			@base_url = @config['admin']['base_url']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new
			#caps['selenium-version'] = "2.53.4"
			caps["name"] = "Create lists"
			caps["build"] = "1.0"
			caps["browser_api_name"] = "Chrome55x64"
            caps["os_api_name"] = "Mac10.12"
			caps["screen_resolution"] = "1920x1200"
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
			@driver.navigate.to(@base_url + "/admins/sign_in")
			# start login process by entering username
			puts "Entering username"
			@driver.find_element(:id, "admin_email").send_keys @config['admin']['email']

			# then we'll enter the password
			puts "Entering password"
			@driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']

			# then we'll click the login button
			puts "Logging in"
			@driver.find_element(:name, "commit").click
			
			 @driver.find_element(:link, "Groups and Lists").click
	sleep(2)
    @driver.find_element(:link, "Create List").click
	sleep(2)
	@driver.find_element(:css, "button.btn-edit").click
	sleep(2)
	@driver.find_element(:css, "input[placeholder='Type a members group name']").clear
	sleep(1)
	@driver.find_element(:css, "input[placeholder='Type a members group name']").send_keys "list creation test via selenium"
	sleep(2)
	@driver.find_element(:css, "span.btn.btn-default.fileinput-button").click
	sleep(1)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Documents\\test.csv")
	sleep(5)
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:css, "a.report-link").click
    @driver.find_element(:link, "Export to CSV").click
	@driver.find_element(:link, "Groups and Lists").click
	sleep(2)
	
	
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			assert @driver.find_element(:xpath, "//div[@class='page-header ng-scope']/h1").text.include?('Groups')
			#wel = @driver.find_element(:xpath, "//div[@class='page-header ng-scope']/h1").text
			#assert_equal("Groups and Lists\nTotal amount of members is **", welcomeText)
			#assertTrue(wel.contains("Groups and Lists"))
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