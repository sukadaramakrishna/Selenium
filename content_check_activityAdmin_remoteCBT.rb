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
			caps["name"] = "Test content of an activity"
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
			
			puts "Redirecting to the mission hubs page"
			@driver.find_element(:link, "Mission Hubs").click
	sleep(1)
	puts "Creating a new mission hub"
    @driver.find_element(:link, "New Mission Hub").click
    @driver.find_element(:xpath, "//div[@ng-model='new_mission_hub.name']/input[1]").clear
    @driver.find_element(:xpath, "//div[@ng-model='new_mission_hub.name']/input[1]").send_keys "Activity Content Check"
	sleep(1)
	@driver.find_element(:css, "button.btn-default").click
	sleep(2)
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(2)
	puts "Creating a new activity"
    @driver.find_element(:link, "New Activity").click
	sleep(2)
    @driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").send_keys "Activity Content Check"
	sleep(1)
    #@driver.find_element(:xpath, "//textarea[@type='text']").click
    @driver.find_element(:xpath, "//textarea[@type='text']").clear
    @driver.find_element(:xpath, "//textarea[@type='text']").send_keys "Activity Content Check"
	sleep(1)
    @driver.find_element(:css, "textarea.test-activity-tagline").clear
    @driver.find_element(:css, "textarea.test-activity-tagline").send_keys "Mission offer"
	sleep(1)
	puts "Adding mission details"
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Mission Details']").click
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Mission Details']").clear
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Mission Details']").send_keys "Mission details"
    sleep(1)
    @driver.find_element(:id, "switch_cb_activity.page.show_details").click
    sleep(2)
	puts "Adding the description of the product"
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").click
    @driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").clear
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").send_keys "Description of the product(offer)"
	sleep(2)
	puts "Adding mission goal"
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	sleep(1)
	puts "Saving .."
	@driver.find_element(:css, "button.test-activity-save").click
	sleep(4)
	puts "Redirecting to offer page"
    @driver.find_element(:link, "Offer Page").click
	sleep(3)
	puts "Switching off the toggle for same content as overview"
    @driver.find_element(:id, "switch_cb_copyContentFromOverview").click
	sleep(1)
	puts "Adding activity content for the offer"
    @driver.find_element(:css, "textarea.mission-page-title").clear
    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity Content Check (offer)"
    sleep(1)
    @driver.find_element(:css, "textarea.test-activity-tagline").clear
    @driver.find_element(:css, "textarea.test-activity-tagline").send_keys "Mission offer (offer)"
	sleep(1)
	puts "Adding activity details for the offer"
	@driver.find_element(:css, 'div.row').click
	@driver.find_element(:css, "div.angular-medium-editor").clear
	@driver.find_element(:css, "div.angular-medium-editor").send_keys "Mission details (offer)"
	sleep(2)
	puts "Saving .."
    @driver.find_element(:css, "button.test-activity-save").click
	sleep(3)
	puts "Redirecting to the mission page"
	@driver.find_element(:link, "Mission Page").click
	sleep(3)
	puts "Adding the description of the product"
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").click
    @driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").clear
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").send_keys "Description of the product"
	sleep(2)
	puts "Saving .."
	@driver.find_element(:css, "button.test-activity-save").click
	sleep(3)
    @driver.find_element(:link, "Activity Content Check").click
	sleep(4)
	puts "Redirecting to mission logic page"
    @driver.find_element(:link, "Mission Logic").click
	sleep(2)
    @driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	puts "Setting up the start and end date"
	@driver.find_element(:id, "date-start").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	puts "Adding group"
	@driver.find_element(:css, "button.mlogic-add-group").click
	#@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2575']").click
	@driver.find_element(:xpath, "//span[text()='All Members']").click
	sleep(1)
	puts "Saving group"
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	#puts "Checking the send samples option"
    @driver.find_element(:css, "span.control-checkbox-dark").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_0']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	puts "Adding spots limit"
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	puts "Saving.."
	@driver.find_element(:css, "button.test-hub-logic-save").click
	puts "Saved settings"
	
	
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = @driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']").text
			assert_equal("Activity Content Check", welcomeText)

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