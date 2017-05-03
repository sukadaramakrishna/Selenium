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
			caps["name"] = "Quick offer set up by an admin"
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
			sleep(4)
			puts "Creating new mission hub"
			$driver.navigate.to(@base_url + "/mission_hubs#?filter=current")
			sleep(1)
			$driver.find_element(:link, "Mission Hubs").click
			
			cbt_api.createQuickOffer()
			cbt_api.previewQuickOffer()
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = $driver.find_element(:xpath, "//div[@class='survey-sidebar-option test-activity-toggle-facebook']/label").text
			assert_equal("Facebook", welcomeText)
			
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
	def createQuickOffer()
	#Creating quick offer and setting up the page
	sleep(4)
	$driver.find_element(:link, "New Mission Hub").click
	sleep(4)
    $driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    $driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Quick offer"
	sleep(2)
	$driver.find_element(:css, "button.btn-default").click
	sleep(2)
	$driver.find_element(:xpath, "//ul[@class='q-builder']/li[4]").click
	sleep(3)
	puts "Creating quick offer"
	$driver.find_element(:link, "New Quick Offer").click
	sleep(3)
	$driver.find_element(:css, "button.btn-edit").click
	sleep(3)
	$driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	$driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Quick offer"
	sleep(2)
	sleep(4)
	puts "Adding title"
    $driver.find_element(:css, "textarea.mission-page-title").clear
	sleep(2)
    $driver.find_element(:css, "textarea.mission-page-title").send_keys "Quick offer (title)"
	sleep(2)
	puts "Adding mission/quick offer text"
	$driver.find_element(:xpath, "//div[@class='mission-page-content']/textarea").send_keys "Quick offer offer text"
	sleep(2)
	puts "Adding quick offer details"
	$driver.find_element(:xpath, "//div[@data-placeholder='Quick Offer Details']").send_keys "Quick offer details"
	sleep(2)
	puts "Adding quick offer link"
	$driver.find_element(:css, "input.q-field.activity-share-url.js-anchor.ng-pristine.ng-valid.placeholder").send_keys "https://www.socialmedialink.com/"
	sleep(2)
	puts "Toggling Image"
    $driver.find_element(:id, "switch_cb_activity.page.show_image").click
	sleep(4)
	e = $driver.find_element(:css, "input.js-description-image-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
    sleep(10)
	puts "Toggling Facebook sharing tool"
	$driver.find_element(:id, "switch_cb_facebook").click
	sleep(4)
	$driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook.seed_url']").clear
	$driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook.seed_url']").send_keys "http://socialmedialink.com/"
	sleep(1)
	$driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").clear
	$driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").send_keys "Suggested Phrase"
	sleep(1)
	puts "Saving settings on quick offer page.."
    $driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	puts "Saved all settings on the quick offer page"
	
	#Setting up the mission logic and launching the activity
	$driver.find_element(:link, "Quick offer").click
	sleep(3)
	puts "Redirecting to mission logic page"
    $driver.find_element(:link, "Mission Logic").click
	sleep(3)
    $driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	puts "Setting up the start and end date"
	$driver.find_element(:id, "date-start").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	$driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	puts "Adding group"
	$driver.find_element(:css, "button.mlogic-add-group").click
	#@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2575']").click
	$driver.find_element(:xpath, "//span[text()='All Members']").click
	sleep(2)
	puts "Saving group"
	$driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	puts "Checking the send samples option"
    $driver.find_element(:css, "span.control-checkbox-dark").click
	$driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_0']").click
	$driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	puts "Adding spots limit"
	$driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	$driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	puts "Saving mission logic.."
	$driver.find_element(:css, "button.test-hub-logic-save").click
	puts "Saved mission logic settings"
	sleep(2)
	end
	def previewQuickOffer
	sleep(3)
	$driver.find_element(:link, "Survey & Activity Pages").click
	sleep(2)
	$driver.find_element(:link, "Quick offer").click
	sleep(2)
	#Clicking preview of the quick offer's mission page
	$driver.find_element(:xpath, "//a[@class='btn btn-invert btn-invert-preview']").click
	sleep(2)
	$driver.switch_to.window($driver.window_handles[1])
	puts "Clicked Preview of the quick offer's mission page. Saved screen shot."
	$driver.save_screenshot "Screenshots/previewQuickOfferMissionPage.png" 
	sleep(2)
	$driver.switch_to.window($driver.window_handles[0])
	sleep(2)
	end
end