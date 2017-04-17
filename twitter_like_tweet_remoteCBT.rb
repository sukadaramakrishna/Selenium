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

			caps["name"] = "Like twitter tweets"
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
			puts "Loading.. Twitter site"
			@driver.get("https://twitter.com/")
	sleep(3)
	@driver.find_element(:xpath, "//div[@class='StreamsHero-buttonContainer']/a[3]").click
	sleep(2)
	puts "siging in to twitter"
	@driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-username']/input").clear
    @driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-username']/input").send_keys @config['signup']['email_twitter']
    sleep(2)
	
    @driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-password']/input").clear
    @driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-password']/input").send_keys @config['signup']['pass_twitter']
    sleep(1)
    @driver.find_element(:css, "input.submit.btn.primary-btn.js-submit").click
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
	puts "logged in"
	#click the name tag
    @driver.find_element(:css, "a.u-textInheritColor").click
	sleep(2)
	@driver.execute_script("scroll(0, 400);")
	sleep(2)

	#Like the post 1
    @driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--favorite js-toggleState'])[1]/button[1]").click
	puts "liked first post"
	sleep(4)
	
	#Like the post 2
	@driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--favorite js-toggleState'])[2]/button[1]").click
	puts "liked second post"
	sleep(4)
	#retweet post 1
	@driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--retweet js-toggleState js-toggleRt'])[1]/button[1]").click
	puts "retweeted first post"
	sleep(4)
	@driver.find_element(:css, "button.btn.primary-btn.retweet-action").click
	sleep(4)
	#retweet post 2
	@driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--retweet js-toggleState js-toggleRt'])[2]/button[1]").click
	puts "retweeted second post"
	sleep(4)
	@driver.find_element(:css, "button.btn.primary-btn.retweet-action").click
	sleep(2)
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