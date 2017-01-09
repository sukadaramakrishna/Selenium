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
			@name = @config['signup']['first_name_CA'] + "." +@config['signup']['last_name_CA']
			@email = @name + "@yopmail.com"
			@pass = @config['member']['pass']
			@zip = @config['signup']['zip_CA']
			@first_name = @config['signup']['first_name_CA']
			@last_name = @config['signup']['last_name_CA']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new

			caps["name"] = "Member Signup Via Email for CA"
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
			
			puts "Signing up via Email for CA"
			sleep(2)
	@driver.find_element(:css, "button.login-switch-button").click
    sleep(2)
	puts "Entering email"
	@driver.find_element(:xpath, "(//input[@id='member_email'])[2]").click
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").send_keys @email
	sleep(2)
	puts "Entering password"
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").send_keys @pass
    sleep(2)
	#@driver.find_element(:css, "label.control-checkbox").click
	sleep(1)
    @driver.find_element(:css, "span").click
	puts "Clicking the Sign up button"
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
	sleep(2)
	puts "Redirecting to yopmail.com"
	@driver.navigate.to("http://yopmail.com");
	sleep(8)
	puts "Opening inbox"
	@driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys @name
    @driver.find_element(:css, "input.sbut").click
	sleep(1)
	puts 'switching to internal iframe'
	@driver.switch_to.frame('ifmail')
	sleep(1)
    puts "Confirming account"
    @href = @driver.find_element(:link, "CONFIRM ACCOUNT").attribute('href')
	puts 'activation link: '+@href
	@driver.get(@href)
	
   puts "Entering first name"
    @driver.find_element(:id, "member_first_name").clear
    @driver.find_element(:id, "member_first_name").send_keys @first_name
	puts "Entering last name"
    @driver.find_element(:id, "member_last_name").clear
    @driver.find_element(:id, "member_last_name").send_keys @last_name
	puts "Entering CA Zipcode"
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @zip
	puts "Choosing CA as country"
	dropdown_list = @driver.find_element(:id, 'member_country')
	#Get all the options from the dropdown
	options = dropdown_list.find_elements(tag_name: 'option')
	#Find the dropdown value by text
	options.each { |option| option.click if option.text == "Canada" }
	sleep(1)
	puts "Entering DOB"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_month")).select_by(:text, "February")
	sleep(1)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_day")).select_by(:text, "7")
	sleep(1)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_year")).select_by(:text, "1991")
	sleep(3)
	puts "Choosing gender"
    @driver.find_element(:xpath, "(//label[@class='control-radio'])[1]").click
	sleep(2)
	puts "Submitting.."
    @driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/tutorial.png"
	@driver.find_element(:css, "a.btn.btn-color.btn-lg").click
	puts "Successfuly signed up via Email for CA"
	sleep(2)

	#@driver.find_element(:xpath, "(//div[@class='tour-navigation'])[1]/div[1]").click
	#sleep(5)
	#puts "Closed tutorial"
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