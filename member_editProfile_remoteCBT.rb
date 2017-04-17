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
			caps["name"] = "Edit profile"
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
			sleep(4)
			puts "Redirecting to the profile section"
			@driver.find_element(:xpath, "//span[@class='header-user-name']").click
    #scroll
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	@driver.save_screenshot "Screenshots/beforeProfileEdit.png"
	sleep(2)
	#Upload profile picture
    #@driver.find_element(:css, "div.btn.btn-color.profile-upload-btn").click
	puts "Uploading the profile picture"
	sleep(2)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\snuggleFbPosts_09_14_hllwn.jpg")
	sleep(10)
	#Fill member about
	puts "Populating member about section"
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_about']").click
	#@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_about']").clear
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_about']").send_keys "member about member about member about"
	#scroll
	@driver.execute_script("scroll(0, 500);")
	sleep(4)
	#Fill Pinterest username
	puts "Adding pinterest name"
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_pinterest_user']").click
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_pinterest_user']").send_keys "alokande"
	sleep(2)
	#save general information
	puts "Saving general information"
	@driver.find_element(:xpath, "//input[@class='btn btn-color btn-lg btn-block js-birthday-submit'][@value='Save General Info']").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0,750);")
	sleep(4)
	#click to change Hispanic option
	puts "Change hispanic option"
	@driver.find_element(:xpath, "(//div[@class='mobile-minimize-content'])[2]/form/div[@class='form-group'][1]/div[2]/button").click
	sleep(1)
	#click Yes  (Hispanic)
	@driver.find_element(:xpath, "(//div[@class='limited-changes-field'])[3]/div[2]/div/select/option[2]").click
	sleep(1)
	#click to change Race and Ethnicity
	puts "Change Race and Ethnicity"
	@driver.find_element(:xpath, "(//div[@class='mobile-minimize-content'])[2]/form/div[@class='form-group'][2]/div[2]/div/button").click
	sleep(1)
	#select asian
	@driver.find_element(:xpath, "(//div[@class='limited-changes-field'])[4]/div[2]/p[2]").click
	sleep(1)
	#Marital status
	puts "Choosing marital status"
	@driver.find_element(:xpath, "(//div[@class='form-group'])[17]/p[1]/label").click
	sleep(1)
	#Choose children
	puts "Choosing no. of children"
	@driver.find_element(:xpath, "(//div[@class='form-group'])[18]/p[1]/label").click
	sleep(1)
	#choose month of birth 
	@driver.find_element(:xpath, "(//div[@class='form-group'])[20]/div[2]/div/div[1]/select/option[2]").click
	sleep(2)
	#choose year of birth
	@driver.find_element(:xpath, "(//div[@class='form-group'])[20]/div[2]/div/div[2]/select/option[4]").click
	sleep(4)
	#scroll
	@driver.execute_script("scroll(0, 2300);")
	sleep(4)
	#Blog
	#@driver.find_element(:xpath, "(//div[@class='form-group'])[21]/p[2]/label").click
	sleep(2)
	#click household income dropbox
	#@driver.find_element(:xpath, "//select[@id='member_household_income']").click
	sleep(2)
	#select household income
	puts "Choosing household income"
	@driver.find_element(:xpath, "//select[@id='member_household_income']/option[4]").click
	sleep(2)
	#save personal information
	puts "Saving personal info"
	@driver.find_element(:xpath, "//input[@value='Save Personal Info']").click
	sleep(2)
	@driver.save_screenshot "Screenshots/afterProfileEdit.png"
	sleep(2)
	puts "Profile has been edited. Test passed."
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