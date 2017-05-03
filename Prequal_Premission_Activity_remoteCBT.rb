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

			caps["name"] = "Prequal Premission Activity"
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
		
	
	#Creating a mission hub
	@driver.find_element(:link, "Mission Hubs").click
	puts "Creating a new mission hub"
	sleep(4)
    @driver.find_element(:link, "New Mission Hub").click
    sleep(4)
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Prequal+Premission+Activity"
	sleep(2)
	@driver.find_element(:css, "button.btn-default").click
	sleep(4)
	
	#Creating Pre qual Survey
	puts "Creating Pre qual survey"
	@driver.find_element(:css, "li.test-hub-new-survey").click
	sleep(4)
	@driver.find_element(:link, "New Survey").click
	sleep(7)
	@driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").send_keys "Prequal Survey"
	#Single Answer Question
	puts "Adding a single type question"
    @driver.find_element(:css, "span.icon-single_answer").click
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").clear
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").send_keys "Single Answer Question "
	sleep(1)
	@driver.find_element(:css, "button.q-list-add").click
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-0").clear
	@driver.find_element(:css, "textarea.test-question-answer-0").send_keys "Answer 1"
	sleep(1)
	@driver.action.send_keys(:enter).perform
	@driver.find_element(:css, "textarea.test-question-answer-1").clear
	@driver.find_element(:css, "textarea.test-question-answer-1").send_keys "Answer 2"
	sleep(1)
	@driver.action.send_keys(:enter).perform
	@driver.find_element(:css, "textarea.test-question-answer-2").clear
	@driver.find_element(:css, "textarea.test-question-answer-2").send_keys "Answer 3"
	sleep(1)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	
    @driver.find_element(:link, "Prequal Survey").click
	sleep(1)
	
	#@driver.find_element(:css, "a.rowclick.test-hub-structure-item-link.ng-binding").click
	sleep(2)
	
	@driver.find_element(:css, "strong.q-list-type-reward").click
	puts "Adding points to the Pre qual survey"
	@driver.find_element(:css, "input.reward-points-field").clear
	@driver.find_element(:css, "input.reward-points-field").send_keys "10"
	sleep(2)
	@driver.find_element(:xpath, "//button[@ng-click='src.update()']").click
	sleep(2)
	puts "Adding badge to Pre qual survey"
   @driver.find_element(:css, "strong.q-list-type-badge").click
	sleep(2)
	puts "abc"
	#@driver.execute_script('$(\'input.js-badge-image-field[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input.js-badge-image-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpe")
	sleep(3)
	@driver.find_element(:css, "textarea.test-activity-badge-name").clear
	@driver.find_element(:css, "textarea.test-activity-badge-name").send_keys "Prequal Survey Badge name"
	@driver.find_element(:xpath, "//button[@ng-click='save()']").click
	sleep(2)
	
	@driver.find_element(:link, "Prequal+Premission+Activity").click
	sleep(1)
	
	#Create Pre mission survey
	puts "Creating pre mission survey"
	@driver.find_element(:css, "li.test-hub-new-survey").click
	sleep(4)
	@driver.find_element(:link, "New Survey").click
	sleep(7)
	@driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").send_keys "Premission Survey"
	#Single Answer Question
	puts "Adding a single answer type question to Pre mission survey"
    @driver.find_element(:css, "span.icon-single_answer").click
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").clear
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").send_keys "Single Answer Question "
	sleep(2)
	@driver.find_element(:css, "button.q-list-add").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-answer-0").clear
	@driver.find_element(:css, "textarea.test-question-answer-0").send_keys "Answer 1"
	sleep(2)
	@driver.action.send_keys(:enter).perform
	@driver.find_element(:css, "textarea.test-question-answer-1").clear
	@driver.find_element(:css, "textarea.test-question-answer-1").send_keys "Answer 2"
	sleep(2)
	@driver.action.send_keys(:enter).perform
	@driver.find_element(:css, "textarea.test-question-answer-2").clear
	@driver.find_element(:css, "textarea.test-question-answer-2").send_keys "Answer 3"
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	
    @driver.find_element(:link, "Premission Survey").click
	sleep(2)
	
	#@driver.find_element(:css, "a.rowclick.test-hub-structure-item-link.ng-binding").click
	sleep(2)
	
	@driver.find_element(:css, "strong.q-list-type-reward").click

	puts "Adding points to Pre mission survey"
	@driver.find_element(:css, "input.reward-points-field").clear
	@driver.find_element(:css, "input.reward-points-field").send_keys "10"
	sleep(2)
	@driver.find_element(:xpath, "//button[@ng-click='src.update()']").click
	sleep(2)
	puts "Adding badge to the pre mission survey"
   @driver.find_element(:css, "strong.q-list-type-badge").click
	sleep(2)
	puts "abc"
	#@driver.execute_script('$(\'input.js-badge-image-field[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input.js-badge-image-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpe")
	sleep(3)
	@driver.find_element(:css, "textarea.test-activity-badge-name").clear
	@driver.find_element(:css, "textarea.test-activity-badge-name").send_keys "Premission Survey Badge name"
	@driver.find_element(:xpath, "//button[@ng-click='save()']").click
	sleep(2)
	
	@driver.find_element(:link, "Prequal+Premission+Activity").click
	sleep(2)
	
	#Creating an activity
	puts "Creating an activity"
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
	
	@driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
	sleep(3)
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Activity PPA"
	
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	
	sleep(2)

    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity PPA"
	sleep(2)
	puts "Adding goal to the activity"
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	
	#Toggle Facebook
	puts "Toggling Facebook"
    @driver.find_element(:id, "switch_cb_facebook").click
	sleep(4)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook.seed_url']").clear
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook.seed_url']").send_keys "http://socialmedialink.com/"
	sleep(2)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").send_keys "Suggested Phrase"
	sleep(2)
	puts "Saving the activity"
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	
	@driver.find_element(:link, "Prequal+Premission+Activity").click
	sleep(2)
	
	#Mission Logic section
	puts "Redirecting to mission logic page"
    @driver.find_element(:link, "Mission Logic").click
	sleep(2)
	puts "Adding mission logic to pre qual survey"
	section = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-0.test-hub-logic-item-survey")
	section[0].find_element(:css, "a").click
    @driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
    @driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:xpath, "//span[text()='All Members']").click
	sleep(2)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(2)
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(2)
	@driver.find_element(:xpath,"//div[@class='mlogic-step ng-scope']/strong[3]").click
	@driver.find_element(:xpath,"//div[@class='inline-select ng-pristine ng-valid open']/ul/li[3]").click
	sleep(2)
	puts "Adding mission logic to pre mission survey"
	section1 = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-1.test-hub-logic-item-survey")
	section1[0].find_element(:css, "a").click
    @driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	@driver.find_element(:xpath,"//div[@class='mlogic-step ng-scope']/strong[3]").click
	@driver.find_element(:xpath,"//div[@class='inline-select ng-pristine ng-valid open']/ul/li[4]").click
	sleep(2)
	puts "Adding mission logic to the activity"
	section2 = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-2.test-hub-logic-item-activity")
	section2[0].find_element(:css, "a").click
    @driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_2']").click
	sleep(1)
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='ng-scope']/div/label/span").click
	sleep(1)
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	puts "Saving .."
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(3)
	puts "Mission logic saved"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']").text
			assert_equal("Prequal Survey", welcomeText)

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