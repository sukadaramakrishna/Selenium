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

			caps["name"] = "Facebook share like comments"
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
			
			#go to Twitter site
			puts "Loading.. Facebook site"
			@driver.get("https://www.facebook.com/")
	sleep(3)
	@driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys @config['signup']['email_facebook']
	puts "Entered FB email"
    sleep(2)
    @driver.find_element(:id, "pass").clear
    @driver.find_element(:id, "pass").send_keys @config['signup']['pass_facebook']
	puts "Entered Pass"
    sleep(1)
    @driver.find_element(:id, "loginbutton").click
	sleep(2)
	puts "Logged in"
	@driver.manage.window.maximize
	sleep(2)
	#click the name tag
    #@driver.find_element(:xpath, "//div[@id='pagelet_welcome_box']/ul/li/div/a").click
	@driver.find_element(:xpath, "//div[@id='userNav']/ul/li/a/div/span").click
	sleep(2)
	
	#scroll down
	@driver.execute_script("scroll(0, 100);")
	sleep(2)
	
	#Like first post
    @driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[1]").click
	#@driver.find_element(:xpath, "(//div[@class='_2r6l']").click
	sleep(2)
	puts "Liked the first post"
	
    #scroll dowm further
	@driver.execute_script("scroll(0, 150);")
	sleep(2)
	
	#Like second post
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[1]").click
	sleep(2)
	puts "Liked the second post"
=begin	
	#scroll up
	@driver.execute_script("scroll(100, 0);")
	sleep(2)
	puts "scrolled"
	#Comment on the first post
	@driver.find_element(:xpath, "(//form[@class='commentable_item']/div[1]/div/div/div/div/div/div/span/span/a)[1]").click
	puts "clicked comment"
	@driver.find_element(:xpath, "(//form[@class='commentable_item']/div[1]/div/div/div/div/div/div/span/span/a)[1]").send_keys "comment1"
	#@driver.find_element(:xpath, "(//div[@class='uiUfi UFIContainer _5pc9 _5vsj _5v9k']/div/div[2]/div/div[2]/div/div/div/div[1]/div/div/div/div[2]/div)[1]").send_keys "comment1"
	sleep(2)
	puts "commented on first post"
	
	#scroll down
	@driver.execute_script("scroll(0, 100);")
	sleep(2)
	
	
	#Comment on the first post
	@driver.find_element(:xpath, "(//form[@class='commentable_item']/div[1]/div/div/div/div/div/div/span/span/a)[2]").click
	@driver.find_element(:xpath, "(//form[@class='commentable_item']/div[1]/div/div/div/div/div/div/span/span/a)[2]").send_keys "comment2"
	sleep(2)
	puts "commented on the second post"
=end
=begin
	#Comment on the first post
	@driver.find_element(:xpath, "(//div[@class='UFIAddCommentInput _1osb _5yk1'])[1]/div/div/div[2]/div/div/div/div").click
	@driver.find_element(:xpath, "(//div[@class='UFIAddCommentInput _1osb _5yk1'])[1]/div/div/div[2]/div/div/div/div").send_keys "comment1"
	sleep(2)

	#scroll up
	@driver.execute_script("scroll(100, 0);")
	sleep(2)
	
	#@driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[2]").click
	sleep(2)
	
	#scroll down
	@driver.execute_script("scroll(0, 50);")
	sleep(2)
	
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[2]").click
	sleep(2)
=end
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[1]/div/div[1]").click
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[1]/div/div[1]").send_keys "comment1"
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[2]/div/div[1]").click
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[2]/div/div[1]").send_keys "comment2"
	#@driver.find_element(:xpath, "(//div[contains(@id,'addComment_')])[1]/div/div[2]/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div").click
	#@driver.find_element(:xpath, "(//div[contains(@id,'addComment_')])[1]/div/div[2]/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div").send_keys "comment1"
	#@driver.find_element(:xpath, "(//div[@class='UFIList'])[1]/div[2]/div/div[2]/div/div/div/div/input").click
	#@driver.find_element(:xpath, "(//div[@class='UFIRow._4oep.UFIAddComment.UFIAddCommentWithPhotoAttacher._2o9m'])[1]").click
	#@driver.find_element(:xpath, "(//div[@class='UFIRow._4oep.UFIAddComment.UFIAddCommentWithPhotoAttacher._2o9m'])[1]").send_keys "comment1"
	#element.equals(driver.switchTo().activeElement()).send_keys "comment"
	#@driver.find_element(:css, "//div[@id='u_0_2u']/div/div[3]/div/div[2]/div/div/div/div[1]").click
	#@driver.find_element(:css, "//div[@id='u_0_2u']/div/div[3]/div/div[2]/div/div/div/div[1]").send_keys "comment1"
	
	#@driver.action.send_keys(:enter).perform
	sleep(2)
	#scroll up
	@driver.execute_script("scroll(100, 0);")
	sleep(2)
	#Share the post
    @driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[3]").click
	#click share from the dropdown
	sleep(2)
    @driver.find_element(:xpath, "(//div[@class='_54ng'])[1]/ul/li[2]/a/span/span").click
	sleep(2)
	#Post the share
    @driver.find_element(:xpath, "//div[@class='_4-88']/button[2]/em").click
	sleep(4)
	puts "Shared the first post"
	#scroll down
	@driver.execute_script("scroll(150,0);")
	sleep(2)
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[3]").click
	#click share from the dropdown
	sleep(1)
    @driver.find_element(:xpath, "(//div[@class='_54ng'])[2]/ul/li[2]/a/span/span").click
	sleep(1)
	#Post the share
    @driver.find_element(:xpath, "//div[@class='_4-88']/button[2]/em").click
	puts "Shared the second post"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//div[@class='global-nav']/div/div/h1").text
			assert_equal("Twitter", welcomeText)

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