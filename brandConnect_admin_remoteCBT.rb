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

			caps["name"] = "Create Brand connect Edit and test sorting of comments"
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
    @driver.find_element(:id, "discussion_title").send_keys "Discussion lengthy Discussion lengthyDiscussion lengthyDiscussion lengthy Discussion lengthyDiscussion lengthyDiscussion lengthyDiscussion lengthyDiscussion lengthy"
    sleep(2)
	puts "Entering message for the title"
	@driver.find_element(:id, "discussion_first_comment_attributes_text").clear
    @driver.find_element(:id, "discussion_first_comment_attributes_text").send_keys "Message lengthy Message lengthyMessage lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy Message lengthy."
    sleep(2)
	puts "Saving discussion .."
	@driver.find_element(:name, "commit").click
    puts "Discussion saved"
	
	#Edit Brand connect Discussion
	sleep(2)
	puts "Editing Brand connect discussion"
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label").click
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label/span/a[1]").click
	sleep(1)
	@driver.find_element(:id, "discussion_title").clear
    @driver.find_element(:id, "discussion_title").send_keys "Discussion 1 just edited"
    sleep(2)
	@driver.find_element(:id, "discussion_first_comment_attributes_text").clear
    @driver.find_element(:id, "discussion_first_comment_attributes_text").send_keys "Message edited"
    sleep(2)
	@driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/brandconnectDicussion_edited.png"
	puts "Brand connect discussion edited successfully."
	
	#Edit Brand connect Topic
	sleep(2)
	puts "Editing Brand connect topic"
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/h1/a[2]").click
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label").click
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label/span/a[1]").click
	sleep(1)
	@driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title 1 just edited"
	sleep(2)
    @driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title 1 just edited"
    sleep(2)
	@driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/brandconnectTopic_edited.png" 
    puts "Brandconnect topic edited successfully."
	
	#Test sorting feature new to old
	puts "Testing if the comments are sorted new to old"
	@driver.find_element(:css, "a.bconnect-discussions-title").click
	sleep(2)
	puts "Adding comments .."
	(0..31).each do |i|
	@driver.find_element(:xpath, "//textarea").clear
    @driver.find_element(:xpath, "//textarea").send_keys "comment #{i}"
	sleep(1)
	@driver.find_element(:css, "a.btn.btn-color.btn-md.bconnect-new-post-submit").click
	sleep(2)
	end
	@driver.save_screenshot "Screenshots/brandconnectNew2OldComments.png" 
	puts "added 31 comments"
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