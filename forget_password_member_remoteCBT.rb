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
	@base_member_url = @config['member']['base_url']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new

			caps["name"] = "Member forgot password functionality"
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
			@driver.navigate.to(@base_member_url + "/home")
			#@driver.get(@base_url + "/home")
			
			#go to Member History
			puts "Clicking forgot password "
	@driver.find_element(:link, "Forgot Password?").click
	sleep(3)
	@driver.find_element(:xpath, "//div[@class='modal-content']/form/input[3]").clear
	@driver.find_element(:xpath, "//div[@class='modal-content']/form/input[3]").send_keys @config['member']['email']
	sleep(2)
	@driver.find_element(:css, "input.login-submit.js-reset-password").click
	sleep(2)
	#redirect to yopmail
	puts "Redirecting to Yopmail"
	@driver.get("http://yopmail.com");
	sleep(4)
	@driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys @config['member']['email']
    @driver.find_element(:css, "input.sbut").click
	sleep(3)
	puts 'switching to internal iframe'
	@driver.switch_to.frame('ifmail')
	sleep(1)
    #click reset password button
	puts "Clicking on reset password button"
    @href = @driver.find_element(:link, "RESET PASSWORD").attribute('href')
	puts 'activation link: '+@href
	@driver.get(@href)
	sleep(3)
	#change password
	puts "Changing password"
	@driver.find_element(:id, "member_password").clear
	@driver.find_element(:id, "member_password").send_keys @config['member']['change_pass']
	sleep(1)
	@driver.find_element(:id, "member_password_confirmation").clear
	@driver.find_element(:id, "member_password_confirmation").send_keys @config['member']['change_pass']
	sleep(1)
	@driver.find_element(:css, "input.btn.btn-color.btn-lg").click
	sleep(2)
	@driver.find_element(:css, "a.header-logout").click
	sleep(2)
	#login to check if the password changed
	"puts logging in to check if the password changed"
	"Logging in with old password"
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/memberforgetpassword_old_pass.png"
	sleep(3)
	puts "logging in with the new password"
	@driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['change_pass']
    @driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/memberforgetpassword_new_pass.png"
	sleep(3)
	puts "Forget password functionality worked correctly."
	puts "The test passed."
	sleep(4)
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//div[@class='content-offer']/h1").text
			assert_equal("Offers for You", welcomeText)

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