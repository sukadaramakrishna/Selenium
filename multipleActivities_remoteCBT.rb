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

			caps["name"] = "Multiple activities"
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
	
	puts "Creating groups"
	@driver.find_element(:link, "Mission Hubs").click
	sleep(2)
    @driver.find_element(:link, "Groups and Lists").click
	sleep(2)
	#Create group for Males
	puts "Creating a Male group"
    @driver.find_element(:link, "Create Group").click
	sleep(2)
    @driver.find_element(:css, "button.btn-edit").click
	sleep(2)
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").send_keys "Males"
	sleep(2)
	
    @driver.find_element(:css, "a.test-group-gender-link").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox.control-checkbox-primary[for='checkbox_criterias.gender_male']").click
	sleep(1)
    #@driver.find_element(:css, "span.ng-scope.ng-binding").click
    #@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div[3]/div/div/div/div/div/div[2]/div/div/div[2]/button").click
    @driver.find_element(:link, "Save").click
	sleep(2)
	puts "Male group created"
	#Create group for Females
	puts "Creating a Female group"
    @driver.find_element(:link, "Create Group").click
	sleep(2)
    @driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").send_keys "Females"
	sleep(2)
    @driver.find_element(:css, "a.test-group-gender-link").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox.control-checkbox-primary[for='checkbox_criterias.gender_female']").click
	sleep(1)
    #@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div[3]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/span/label/span/span").click
    @driver.find_element(:link, "Save").click
	sleep(2)
	puts "Female group created"
	
	@driver.find_element(:link, "Mission Hubs").click
	#Creating a mission hub
	puts "Creating a new mission hub"
	sleep(4)
    @driver.find_element(:link, "New Mission Hub").click
    sleep(4)
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Multiple activities"
	sleep(2)
    @driver.find_element(:css, "button.btn.btn-default").click
	sleep(4)
	
	#Creating the first activity
	puts "Creating the first activity"
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
    sleep(3)
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Activity for Males"
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	sleep(2)
    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity for Males"
	sleep(1)
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	#Toggle Face2face
    @driver.find_element(:id, "switch_cb_face2face").click
	sleep(2)
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	puts "First activity saved"
	#Creating the second activity
	puts "Creating the second activity"
    @driver.find_element(:link, "Multiple activities").click
	sleep(1)
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
    sleep(3)
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Activity for Females"
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	sleep(2)
    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity for Females"
	sleep(1)
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	#Toggle Face2face
    @driver.find_element(:id, "switch_cb_face2face").click
	sleep(2)
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	puts "Second activity saved"
	
	#Mission Logic section
	puts "Redirecting to mission logic page"
    @driver.find_element(:link, "Multiple activities").click
    sleep(2)
    @driver.find_element(:link, "Mission Logic").click
	sleep(2)
	#define the two mission logic sections
	puts "Adding mission logic for the first activity"
	section = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-0.test-hub-logic-item-activity")
	section[0].find_element(:css, "a").click
	puts "Adding start and end date"
	@driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	puts "Adding Male group"
	@driver.find_element(:css, "button.mlogic-add-group").click
	#@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2568']").click
	@driver.find_element(:xpath, "//span[text()='Males']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	puts "Checking the send samples"
    @driver.find_element(:css, "span.control-checkbox-dark").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_0']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	puts "Adding spot limit"
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(4)
	puts "Saving mission logic for the first activity"
	@driver.find_element(:css, "a.mlogic-close").click
	sleep(2)
	@driver.find_element(:link, "Mission Logic").click
	sleep(2)
	@driver.execute_script("scroll(0, 250);")
	sleep(1)
	#@driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	#@driver.find_element(:xpath,"(//div[@class='mlogic-title.ng-binding'])[1]")
	sleep(3)
	section1 = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-1.test-hub-logic-item-activity")
	puts "Adding mission logic for the second activity"
	section1[0].find_element(:css, "a").click
	#@driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	@driver.find_element(:css,"li.mlogic-list-item.test-hub-logic-item-1.test-hub-logic-item-activity")
	puts "Adding start and end date"
	@driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	puts "Adding Female group"
	@driver.find_element(:css, "button.mlogic-add-group").click
	#@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2569']").click
	@driver.find_element(:xpath, "//span[text()='Females']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
    @driver.find_element(:css, "span.control-checkbox-dark").click
	puts "Checking the send samples"
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_1']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	puts "Adding spot limit"
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(3)
	
	puts "Saving mission logic for the second activity"
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(2)
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']").text
			assert_equal("Activity for Males", welcomeText)

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