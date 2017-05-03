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
			caps["name"] = "Preview test of survey and activity"
			caps["build"] = "1.0"
			caps["browser_api_name"] = "Chrome55x64"
            caps["os_api_name"] = "Mac10.12"
			caps["screen_resolution"] = "1920x1200"
			caps["record_video"] = "true"
			caps["record_network"] = "true"

			
			$driver = Selenium::WebDriver.for(:remote,
			:url => "http://#{username}:#{authkey}@hub.crossbrowsertesting.com:80/wd/hub",
			:desired_capabilities => caps)

			session_id = $driver.session_id
			
			$driver.file_detector = lambda do |args|
			# args => ["/path/to/file"]
			str = args.first.to_s    
			str if File.exist?(str)
			end
			score = "pass"
			cbt_api = CBT_API.new
			# maximize the window - DESKTOPS ONLY
			$driver.manage.window.maximize

			puts "Loading URL"
			$driver.navigate.to(@base_url + "/admins/sign_in")
			# start login process by entering username
			puts "Entering username"
			$driver.find_element(:id, "admin_email").send_keys @config['admin']['email']

			# then we'll enter the password
			puts "Entering password"
			$driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']

			# then we'll click the login button
			puts "Logging in"
			$driver.find_element(:name, "commit").click
			sleep(4)
			puts "Redirecting to mission hub page"
			$driver.find_element(:link, "Mission Hubs").click
			sleep(2)
			
			#Previewing Survey pages
			$driver.find_element(:link, "Survey ABC").click
			sleep(4)
			$driver.find_element(:link, "Survey & Activity Pages").click
			sleep(3)
			$driver.find_element(:link, "Survey ABC").click
			sleep(3)
			#Clicking preview on the questions page
			$driver.find_element(:xpath, "//a[@class='btn btn-invert btn-invert-preview']").click
			sleep(2)
			$driver.switch_to.window($driver.window_handles[1])
			#@driver.keyboard.send_keys[:control,'t']
			sleep(1)
			puts "switched tab"
			puts "Clicked Preview on the survey questions page. Saved screen shot"
			$driver.save_screenshot "Screenshots/previewSurveyQuestionPage.png" 
			sleep(1)
			#@driver.keyboard.send_keys[:control,:tab]
			#Redirecting to survey offer page
			$driver.switch_to.window($driver.window_handles[0])
			sleep(2)
			$driver.find_element(:link, "Offer").click
			sleep(4)
			#Clicking preview on the offer page
			$driver.find_element(:xpath, "//a[@class='btn btn-invert btn-invert-preview']").click
			sleep(2)
			$driver.switch_to.window($driver.window_handles[2])
			puts "switched tab"
			puts "Clicked Preview on the survey offer page. Saved screen shot."
			$driver.save_screenshot "Screenshots/previewSurveyOfferPage.png" 
			sleep(1)
			$driver.switch_to.window($driver.window_handles[0])
			#Redirecting to survey skip logic page
			$driver.find_element(:link, "Skip Logic").click
			sleep(4)
			#Clicking preview on the skip logic page
			$driver.find_element(:xpath, "//a[@class='btn btn-invert btn-invert-preview']").click
			sleep(2)
			$driver.switch_to.window($driver.window_handles[3])
			puts "Clicked Preview on the survey offer page. Saved screen shot."
			$driver.save_screenshot "Screenshots/previewSurveySkipLogicPage.png" 
			sleep(1)
			$driver.switch_to.window($driver.window_handles[0])
			cbt_api.previewActivity()
			
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = $driver.find_element(:xpath, "//label[@for='switch_cb_copyContentFromOverview']").text
			assert_equal("Same Content as on the Overview", welcomeText)
			
			puts "Taking Snapshot"
			cbt_api.getSnapshot(session_id)
			cbt_api.setScore(session_id, "pass")

		rescue Exception => ex
		    puts ("#{ex.class}: #{ex.message}")
		    cbt_api.setScore(session_id, "fail")
		ensure     
		    $driver.quit
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
	def previewActivity()
	puts "Preview Activity"
	sleep(2)
	$driver.find_element(:link, "Mission Hubs").click
	puts "Clicked mission hubs"
	sleep(5)
	#@@driver.find_element(:link, "Sharing Tools").click
	$driver.find_element(:xpath, "//div[@class='col-md-4 col-sm-6 row-click test-hub-item2']").click
	sleep(2)
	puts "Clicked sharing tools"
	$driver.find_element(:link, "Survey & Activity Pages").click
	sleep(2)
	puts "Clicked survey and activity pages"
	$driver.find_element(:link, "Sharing Tools Activity").click
	sleep(4)
	puts "Clicked on sharing tools activity"
	#Clicking preview of the activity on the mission page
	$driver.find_element(:xpath, "//a[@class='btn btn-invert btn-invert-preview']").click
	sleep(2)
	$driver.switch_to.window($driver.window_handles[4])
	puts "Clicked Preview of Activity on Mission page. Saved screen shot."
	$driver.save_screenshot "Screenshots/previewActivityMissionPage.png" 
	sleep(2)
	$driver.switch_to.window($driver.window_handles[0])
	#Clicking preview of the activity on the offer page
	$driver.find_element(:link, "Offer Page").click
	sleep(4)
	$driver.find_element(:xpath, "//a[@class='btn btn-invert btn-invert-preview']").click
	sleep(2)
	$driver.switch_to.window($driver.window_handles[5])
	puts "Clicked Preview of Activity on offer page. Saved screen shot."
	$driver.save_screenshot "Screenshots/previewActivityOfferPage.png" 
	sleep(2)
	$driver.switch_to.window($driver.window_handles[0])
	sleep(4)
	end
	
end