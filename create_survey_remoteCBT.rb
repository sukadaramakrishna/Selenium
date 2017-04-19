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
			caps["name"] = "Create survey"
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
			
			puts "Creating new mission hub"
			sleep(3)
			@driver.find_element(:link, "Mission Hubs").click
			sleep(2)
    @driver.find_element(:link, "New Mission Hub").click
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Survey ABC"
	sleep(2)
   	@driver.find_element(:css, "button.btn-default").click
	sleep(2)
	@driver.find_element(:css, "li.test-hub-new-survey").click
	sleep(5)
	puts "Creating new Survey"
    @driver.find_element(:link, "New Survey").click
	sleep(7)
	@driver.find_element(:css, "button.btn-edit").click
	sleep(1)
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").send_keys "Survey ABC"
	#Single Answer Question
	puts "Adding Single answer question"
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
	#Multiple Answer Question
	puts "Adding multiple answer question"
	@driver.find_element(:css, "li.test-question-new-multiple_answers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Multiple Answer Question "
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-answer-0").clear
	@driver.find_element(:css, "textarea.test-question-answer-0").send_keys "Answer 1"
	@driver.action.send_keys(:enter).perform
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-1").clear
	@driver.find_element(:css, "textarea.test-question-answer-1").send_keys "Answer 2"
	@driver.action.send_keys(:enter).perform
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-2").clear
	@driver.find_element(:css, "textarea.test-question-answer-2").send_keys "Answer 3"
	sleep(1)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	#Text Question
	puts "Adding text question"
	@driver.find_element(:css, "li.test-question-new.test-question-new-text").click
	sleep(3)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Text Question "
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	#Numbers Question
	puts "Adding number question"
	@driver.find_element(:css, "li.test-question-new.test-question-new-numbers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Numbers Question "
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	#Yes or No
	puts "Adding yes/no question"
	@driver.find_element(:css, "li.test-question-new.test-question-new-yes_or_no").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Yes or No Question "
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	
	#Matrix Single
	puts "Adding single matrix question"
	@driver.find_element(:css, "li.test-question-new.test-question-new-matrix_with_single_answer").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Single Matrix Question "
	sleep(2)
	puts "Adding rows"
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").send_keys "row 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").send_keys "row 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").send_keys "row 3"
	sleep(2)
	puts "Adding columns"
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").send_keys "col 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").send_keys "col 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").send_keys "col 3"
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	#Matrix Multiple
	puts "Adding multiple matrix question"
	@driver.find_element(:css, "li.test-question-new.test-question-new-matrix_with_multiple_answers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Multiple Matrix Question "
	sleep(2)
	puts "Adding rows"
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").send_keys "row 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").send_keys "row 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").send_keys "row 3"
	sleep(2)
	puts "Adding columns"
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").send_keys "col 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").send_keys "col 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").send_keys "col 3"
	sleep(2)
	
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	
    @driver.find_element(:link, "Survey ABC").click
	sleep(1)
	
	@driver.find_element(:css, "a.rowclick.test-hub-structure-item-link.ng-binding").click
	sleep(2)
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 400);")
	sleep(4)
	puts "Adding survey points"
	 @driver.find_element(:css, "strong.q-list-type-reward").click

	
	@driver.find_element(:css, "input.reward-points-field").clear
	@driver.find_element(:css, "input.reward-points-field").send_keys "10"
	sleep(2)
	@driver.find_element(:xpath, "//button[@ng-click='src.update()']").click
	sleep(2)
	puts "Adding survey badges"
   @driver.find_element(:css, "strong.q-list-type-badge").click
	sleep(2)
	
	#@driver.execute_script('$(\'input.js-badge-image-field[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input.js-badge-image-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpe")
	sleep(3)
	puts "Adding Badge name"
	@driver.find_element(:css, "textarea.test-activity-badge-name").clear
	@driver.find_element(:css, "textarea.test-activity-badge-name").send_keys "Survey ABC Badge name"
	@driver.find_element(:xpath, "//button[@ng-click='save()']").click
	sleep(2)
	
	@driver.find_element(:link, "Survey ABC").click
	sleep(1)
	
	puts "Adding Survey logic"
	puts "Redirecting to mission logic page"
	@driver.find_element(:link, "Mission Logic").click
	sleep(1)
	#@driver.find_element(:css, "div.mlogic-step.ng-scope").click
	@driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	puts "Adding start and end date"
    @driver.find_element(:id, "date-start").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	#@driver.find_element(:xpath, "//td[@class='day active']").click
	puts "Adding group"
    @driver.find_element(:css, "button.mlogic-add-group").click
	#@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2575']").click
	#@driver.find_element(:css, "label.control-checkbox-primary[contains(for(),'checkbox__']").click
	@driver.find_element(:xpath, "//span[text()='All Members']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	"Checking send samples"
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_0']").click
	sleep(1)
	puts "Adding spot limit"
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	puts "Saving .."
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(2)
	puts "Mission logic saved"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = @driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']").text
			assert_equal("Survey ABC", welcomeText)

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