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

			caps["name"] = "Set Account, Theme, Contact and Assets"
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
			@driver.navigate.to(@base_url + "/admins/sign_in")
			#@driver.get(@base_url + "/home")
			
			puts "Entering member email"
			@driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
	puts "Entering member password"
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
	puts "Logging in"
    @driver.find_element(:name, "commit").click
	sleep(5)
	
	#Click Administration
	puts "Clicking the administration link"
    @driver.find_element(:link, "Administration").click
	
	#Click Account
    @driver.find_element(:link, "Account").click
	puts "Clicking the account link"
    @driver.find_element(:xpath, "//button[@class='btn btn-default pull-right'][@ng-hide='edit_state']").click
	sleep(2)
	#Upload an account logo
	#@driver.execute_script('$(\'input.js-logo-field[type="file"]\').attr("style", "");');
	sleep(1)
	puts "Uploading the account logo"
	e = @driver.find_element(:css, "input.js-logo-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	#Save
	puts "Saving account details.."
    @driver.find_element(:css, "a.btn.btn-default").click
	sleep(2)
	puts "Account details saved"
	
	#Click Theme
	puts "Clicking the theme link"
    @driver.find_element(:link, "Theme").click
	#delete default Theme
    @driver.find_element(:css, "button.btn-trash-photo").click
	#Upload Theme 
	#@driver.execute_script('$(\'input.background-field[type="file"]\').attr("style", "");');
	sleep(1)
	puts "Uploading the theme"
	e = @driver.find_element(:css, "input.background-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
	#Upload Account Logo
	puts "Uploading the account logo"
	#@driver.execute_script('$(\'input.logo-field[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input.logo-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
	#Upload Account Favicon
	puts "Uploading the account favicon"
	#@driver.execute_script('$(\'input.favicon-field[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input.favicon-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
    #Save
	#@driver.find_element(:xpath, "//button[@class='btn.btn-default.pull-right'][@type='submit']").click
	puts "Saving Theme settings.."
	@driver.find_element(:css, "button.btn.btn-default.pull-right").click
	puts "Theme saved"
	
	#Click Contact information
	puts "Click the contact information"
    @driver.find_element(:link, "Contact Information").click
	@driver.find_element(:id, "account_contacts").clear
    @driver.find_element(:id, "account_contacts").send_keys "Contact information Contact information \nContact information"
	@driver.find_element(:name, "commit").click
	puts "Saving contact information.."
	puts "Contact info saved"
	#Click Assets
	#Terms and conditions
	puts "Click assets settings"
    @driver.find_element(:link, "Assets").click
    @driver.find_element(:id, "policy_name").clear
    @driver.find_element(:id, "policy_name").send_keys "Terms and condition name"
    @driver.find_element(:id, "policy_text").clear
    @driver.find_element(:id, "policy_text").send_keys "Terms and condition  Text Terms and condition  Text Terms and condition  Text Terms and condition  TextTerms and condition  Text\n\nTerms and condition  TextTerms and condition  TextTerms and condition  TextTerms and condition  TextTerms and condition  TextTerms and condition  Text"
    @driver.find_element(:name, "commit").click
	puts "Terms and condition saved"
	#Scroll
	@driver.execute_script("scroll(0, 250);")
	sleep(2)
	
	#Privacy
    @driver.find_element(:xpath, "(//input[@class='form-control'][@id='policy_name'])[2]").clear
    @driver.find_element(:xpath, "(//input[@class='form-control'][@id='policy_name'])[2]").send_keys "Privacy Name"
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[2]").click
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[2]").clear
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[2]").send_keys "Privacy Text Privacy TextPrivacy TextPrivacy TextPrivacy TextPrivacy TextPrivacy Text\n\nPrivacy TextPrivacy TextPrivacy Text"
    @driver.find_element(:xpath, "//input[@name='commit'][@value='Update Privacy']").click
	puts "Privacy details saved"
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Disclosure
    @driver.find_element(:xpath, "(//input[@class='form-control'][@id='policy_name'])[3]").clear
    @driver.find_element(:xpath, "(//input[@class='form-control'][@id='policy_name'])[3]").send_keys "Disclosure Name"
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[3]").clear
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[3]").send_keys "Disclosure Text Disclosure TextDisclosure TextDisclosure TextDisclosure Text\nDisclosure TextDisclosure TextDisclosure TextDisclosure Text"
    @driver.find_element(:xpath, "//input[@name='commit'][@value='Update Disclosure']").click
	puts "Disclosure details saved"
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#About us
    @driver.find_element(:xpath, "(//input[@class='form-control'][@id='policy_name'])[4]").clear
    @driver.find_element(:xpath, "(//input[@class='form-control'][@id='policy_name'])[4]").send_keys "About Us name"
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[4]").clear
    @driver.find_element(:xpath, "(//textarea[@class='form-control'][@id='policy_text'])[4]").send_keys "About Us Text About Us TextAbout Us TextAbout Us TextAbout Us Text\n\nAbout Us TextAbout Us TextAbout Us Text"
    @driver.find_element(:xpath, "//input[@name='commit'][@value='Update About Us']").click
	puts "About us details saved"
	puts "Redirected to Home page"
    @driver.find_element(:link, "Home Page").click
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//div[@class='page-header']/h1").text
			assert_equal("Administration", welcomeText)

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