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
			@resend_base_url = @config['member']['resend_confirm_url']
			@name = @config['member']['resend_confirm']
			@pass = @config['member']['pass']
			@zip = @config['signup']['zip_CA']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new
			#caps['selenium-version'] = "2.53.4"
			caps["name"] = "Resend confirmation emails"
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
			@driver.navigate.to(@base_url + "/home")
			sleep(4)
			puts "signing up"
			@driver.find_element(:css, "button.login-switch-button").click
			sleep(2)
			# start login process by entering username
			puts "Entering username"
			@driver.find_element(:xpath, "(//input[@id='member_email'])[2]").click
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").send_keys @name
	sleep(2)

			# then we'll enter the password
			puts "Entering password"
			 @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").send_keys @pass
    sleep(2)

			# then we'll click the login button
			puts "Logging in"
			 @driver.find_element(:css, "span").click
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
	sleep(2)
			
			#resend confirmation
    @driver.get(@resend_base_url)
	sleep(3)
	@driver.find_element(:xpath, "//div[@class='col-sm-9']/input").send_keys @name
	sleep(1)
	@driver.find_element(:css, "input.btn.btn-color.btn-lg").click
	sleep(1)
	puts "The test was successfull"
	sleep(2)
	#Verify if you got two emails in Yopmail
	@driver.get("http://yopmail.com");
	sleep(4)
	@driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys @name
    @driver.find_element(:css, "input.sbut").click
	sleep(1)
	@driver.save_screenshot "Screenshots/resendConfirmationEmails.png"
	puts "Screen shot of yopmail taken"
	sleep(1)
	
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			#assert @driver.find_element(:xpath, "//div[@class='page-header ng-scope']/h1").text.include?('Groups')
			#assert @driver.find_element(:xpath, "//div[@class='bconnect-topic-bar']").text.include?('discussion')
			wel = @driver.find_element(:xpath, "//td[@style='padding-left:12px;padding-right:0px; vertical-align:top;width:1000px; ']/div[3]").text.include?('yopmail.com ')
			#wel = @driver.find_element(:xpath, "(//td[@class='mcnTextContent'])[2]/h1").text
			#assert_equal("Password Reset", welcomeText)
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
   
  