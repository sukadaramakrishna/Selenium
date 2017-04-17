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
			caps["name"] = "SharingAll Admin"
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
			@driver.navigate.to(@config['admin']['base_url']	+ "/admins/sign_in")
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
			@driver.navigate.to(@base_url + "/mission_hubs#?filter=current")
			sleep(1)
			@driver.find_element(:link, "Mission Hubs").click
	sleep(4)
    @driver.find_element(:link, "New Mission Hub").click
	sleep(4)
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Sharing Tools"
	sleep(2)
	@driver.find_element(:css, "button.btn-default").click
	sleep(2)
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
	puts "Creating new activity"
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
	sleep(3)
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Sharing Tools Activity"
	
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	
	sleep(2)

    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Sharing Tools Activity"
	sleep(1)
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
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").send_keys "Suggested Phrase"
	sleep(1)

	#Toggle Facebook Page
	puts "Toggling Facebook page"
	@driver.find_element(:id, "switch_cb_facebook_page").click
	sleep(4)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook_page.seed_url']").clear
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook_page.seed_url']").send_keys "http://socialmedialink.com/"
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook_page.suggested_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook_page.suggested_phrase']").send_keys "Facebook Page Suggested Phrase"
	sleep(1)
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	
	#Toggle Twitter
	puts "Toggling Twitter"
    @driver.find_element(:id, "switch_cb_twitter").click
	sleep(1)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.twitter.seed_url']").clear
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.twitter.seed_url']").send_keys "http://socialmedialink.com/"
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.seed_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.seed_phrase']").send_keys "Seed Phrase"
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.suggested_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.suggested_phrase']").send_keys "Suggested Phrase"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Toggle Face2face
	puts "Toggling Face2face"
    @driver.find_element(:id, "switch_cb_face2face").click
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Toggle Upload Facebook
	puts "Toggling Upload to Facebook"
	@driver.find_element(:id, "switch_cb_upload_photo_facebook").click
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_facebook.suggested_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_facebook.suggested_phrase']").send_keys "Upload photo to facebook suggested Phrase"
	sleep(2)

	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Toggle Upload Photo Facebook Page
	puts "Toggling upload to Facebook page"
	@driver.find_element(:id, "switch_cb_upload_photo_fb_page").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_fb_page.suggested_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_fb_page.suggested_phrase']").send_keys "Upload photo to facebook page suggested Phrase"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Toggle Upload Twitter
	puts "Toggling Upload to Twitter"
	@driver.find_element(:id, "switch_cb_upload_photo_twitter").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.seed_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.seed_phrase']").send_keys "Upload photo to twitter seed Phrase"
	sleep(2)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.suggested_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.suggested_phrase']").send_keys "Upload photo to twitter suggested Phrase"
	
	#scroll
	@driver.execute_script("scroll(0, 800);")
	sleep(4)
	
	#Toggle Blog
	puts "Toggling Blog"
	@driver.find_element(:id, "switch_cb_blog").click
	sleep(2)

	#Toggle Youtube
	puts "Toggling Youtube"
	@driver.find_element(:id, "switch_cb_youtube").click
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(1)
	
	
	#Toggle Pinterest
	puts "Toggling Pinterest"
	@driver.find_element(:id, "switch_cb_pinterest").click
	sleep(2)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.pinterest.seed_url']").send_keys "https://smiley.socialmedialink.com"
	sleep(1)
	@driver.find_element(:css, "textarea[ng-model='activity.pinterest.suggested_phrase']").send_keys "Click this pin to visit Smiley360! You'll love being a member :)"
	#@driver.execute_script('$(\'input.js-pinterest-image[type="file"]\').attr("style", "");');
	sleep(1)
	#@driver.find_element(:css, "input.js-pinterest-image[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)

	e = @driver.find_element(:css, "input.js-pinterest-image[type='file']")
	#((RemoteWebElement) e ).setFileDetector(new LocalFileDetector())
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
    sleep(15)
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#Toggle Instagram
	puts "Toggling Instagram"
	@driver.find_element(:id, "switch_cb_instagram").click
	sleep(3)
	#scroll
	@driver.execute_script("scroll(0, 2000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.instagram.seed_phrase']").send_keys "Share Smiley360 with your Instagram followers! Submit a link to your Instagram photo in the box below for 10 points. <em>Links must follow the format http://instagram.com/p/xxxxxxxxxx</em>"
	sleep(2)
	

	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#Toggle Brandconnect
	puts "Toggling Brandconnect"
	@driver.find_element(:id, "switch_cb_brand_connect").click
	sleep(3)
	#scroll
	@driver.execute_script("scroll(0, 2000);")
	sleep(4)
	@driver.find_element(:xpath, "//div[@id='s2id_topic-search']").click
	#@driver.find_element(:xpath, "//a[@class='select2-choice']").click
	sleep(3)
	drop = @driver.find_element(:id, "select2-results-3")
	drop.find_element(:css,"li.select2-results-dept-0.select2-result.select2-result-selectable.select2-highlighted").click
	sleep(2)

	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#Toggle retail review
	puts "Toggling Retail review"
	@driver.find_element(:id, "switch_cb_retail_review").click
	sleep(3)
	#scroll
	@driver.execute_script("scroll(0, 2800);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.retail_review.seed_phrase']").send_keys "Retail Review Instructions Retail Review Instructions Retail Review Instructions Retail Review Instructions"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1200);")
	sleep(4)
	
	#Toggle Email Invite
	puts "Toggling Email invite"
	@driver.find_element(:id, "switch_cb_email_group_invite").click
	sleep(1)
	#@driver.find_element(:css, "textarea#template_name").clear
	#@driver.find_element(:css, "textarea#template_name").send_keys "smiley-email-sharing"
	sleep(1)
	#@driver.find_element(:css, "textarea#custom_landing_page_url").clear
	#@driver.find_element(:css, "textarea#custom_landing_page_url").send_keys "http://83prodtest.socialmedialink.com/invite/"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1200);")
	sleep(4)
	
	#Toggle Bazaar Voice
	puts "Toggling Bazaar Voice"
	@driver.find_element(:id,"switch_cb_bazaarvoice").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 2800);")
	sleep(4)
	@driver.find_element(:css, "textarea[placeholder='Bazaar Voice Client Token']").clear
	@driver.find_element(:css, "textarea[placeholder='Bazaar Voice Client Token']").send_keys "ca8YG3gyZph6ZaZxUxm8ep2pD9ZDJE3jneBRs89WwnZiA"
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Bazaar Voice Encoding Key']").clear
	@driver.find_element(:css, "textarea[placeholder='Bazaar Voice Encoding Key']").send_keys "6VgQ5XhdqOaVnj2FlvjqjMTxc"
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Bazaar Voice Product ID']").clear
	@driver.find_element(:css, "textarea[placeholder='Bazaar Voice Product ID']").send_keys "Product10"
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Instructions for member']").clear
	@driver.find_element(:css, "textarea[placeholder='Instructions for member']").send_keys "Bazzar Voice Instructions"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1200);")
	sleep(4)
	
	
	#Toggle Share A Link
	puts "Toggling Share A Link"
	@driver.find_element(:id, "switch_cb_share_link").click
	sleep(1)
	
	#scroll
	@driver.execute_script("scroll(0, 3000);")
	sleep(4)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.share_link.seed_url']").send_keys "http://www.google.com/"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0,1500);")
	sleep(4)
	
	#save
	puts "Saving.."
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	puts "Saved all settings"

	#Mission logic section
	@driver.find_element(:link, "Sharing Tools").click
	sleep(3)
	puts "Redirecting to mission logic page"
    @driver.find_element(:link, "Mission Logic").click
	sleep(3)
    @driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	puts "Setting up the start and end date"
	@driver.find_element(:id, "date-start").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	@driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	puts "Adding group"
	@driver.find_element(:css, "button.mlogic-add-group").click
	#@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2575']").click
	@driver.find_element(:xpath, "//span[text()='All Members']").click
	sleep(2)
	puts "Saving group"
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	puts "Checking the send samples option"
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
	sleep(2)
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = @driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']").text
			assert_equal("Sharing Tools Activity", welcomeText)

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