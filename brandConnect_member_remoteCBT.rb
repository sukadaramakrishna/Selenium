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

			caps["name"] = "Create Brand connect and comment as a member"
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
			#@driver.get(@base_url + "/home")
			
			puts "Entering member email"
			@driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "member_password").clear
	puts "Entering member password"
    @driver.find_element(:id, "member_password").send_keys @config['admin']['pass']
	puts "Logging in"
    @driver.find_element(:name, "commit").click
	sleep(5)

	#Creating topic
	puts "Creating topic"
	@driver.find_element(:link, "Brand Connect").click
    @driver.find_element(:link, "Create Topic").click
	sleep(2)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	e = @driver.find_element(:css, "input[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	puts "Entering topic title"
    @driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title lengthy Title Title"
	sleep(2)
    @driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title lengthy Title lengthy Title lengthy Title lengthy Title lengthyTitle lengthy Title lengthy Title lengthy Title lengthy Title lengthy Title lengthy"
    sleep(2)
	puts "Saving topic .."
	@driver.find_element(:name, "commit").click
	puts "Topic saved"
	
	#Create discussion
	puts "Creating discussion"
    @driver.find_element(:link, "Start the Discussion").click
	sleep(2)
	puts "Entering discussion title"
    @driver.find_element(:id, "discussion_title").clear
    @driver.find_element(:id, "discussion_title").send_keys "Discussion created for member to comment"
    sleep(2)
	puts "Entering message for the title"
	@driver.find_element(:id, "discussion_first_comment_attributes_text").clear
    @driver.find_element(:id, "discussion_first_comment_attributes_text").send_keys "Discussion created for member to comment"
    sleep(2)
	puts "Saving discussion .."
	@driver.find_element(:name, "commit").click
    puts "Discussion saved"
	
	#Login as a member
	puts "Logging in as a member"
	@driver.find_element(:css, "a.header-logout").click
	sleep(1)
	@driver.navigate.to(@config['member']['base_url'] + "/home")
	#login
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(5)
	@driver.manage.window.maximize
	sleep(2)
	puts "Logged in as a member"
	
	#confirmMemberCannotCreateTopic
	puts "Confirming that member cannot create a Topic"
	@driver.find_element(:link, "Brand Connect").click
	sleep(1)
	@driver.save_screenshot "Screenshots/brandconnectconfirmMemberCannotCreateTopic.png"
	sleep(1)
	puts "Create button does not exist. Hence, a member cannot create a Topic."
	
	#commentMember
	@driver.find_element(:xpath, "//div[@class='bconnect-topics-item']/ul/li/h4/a[@title='Discussion created for member to comment']").click
	sleep(1)
	@driver.find_element(:xpath, "//textarea").clear
    @driver.find_element(:xpath, "//textarea").send_keys "comment 1"
	sleep(2)
	@driver.find_element(:css, "a.btn.btn-color.btn-md.bconnect-new-post-submit").click
	sleep(2)
	puts "Member commented on the discussion"
	puts "Test passed"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//span[@class='bconnect-posts-item-links']/a").text
			assert_equal("Comment", welcomeText)

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