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
			@base_member_url = @config['member']['base_url']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new
			#caps['selenium-version'] = "2.53.4"
			caps["name"] = "SharingAll Member Share"
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
			# start login process by entering username
			puts "Entering username"
			@driver.find_element(:id, "member_email").send_keys @config['member']['email']

			# then we'll enter the password
			puts "Entering password"
			@driver.find_element(:id, "member_password").send_keys @config['member']['pass']

			# then we'll click the login button
			puts "Logging in"
			@driver.find_element(:name, "commit").click
			
			#Accept activity
			puts "Accept an activity"
			sleep(4)
	@driver.find_element(:link, "Dashboard").click
	sleep(2)
	@driver.find_element(:link, "Sharing Tools Activity").click
	sleep(2)
	@driver.find_element(:xpath, "//*[contains(text(), 'Accept')]").click
	sleep(1)
	@driver.find_element(:css,"input.btn.btn-color.btn-lg.btn-block").click
	sleep(2)
	
	#Member shares via all the sharing tools
	puts "Member shares via all the sharing tools"
	buttons = @driver.find_elements(:css, "div.sharing-list-buttons")
	
	#Facebook post
	puts "Member shares via Facebook"
	buttons[0].find_element(:css, 'a').click
	#@driver.execute_script("scroll(0, 250);")
	#sleep(1)
	@driver.find_element(:css, "button.btn-color[sml-fill-text='Suggested Phrase']").click
	sleep(1)
	textareas = @driver.find_elements(:css, "div.relative")
	textareas[0].find_element(:css, 'textarea').send_keys " member text member text member text member text member text member text"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='facebook_cb']").click
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	
	#Facebook page post
	puts "Member shares via Facebook Page"
	buttons[1].find_element(:css, 'a').click
	#@driver.execute_script("scroll(0, 250);")
	#sleep(1)
	@driver.find_element(:css, "button.btn-color[sml-fill-text='Facebook Page Suggested Phrase']").click
	sleep(1)
	#textareas = @driver.find_elements(:css, "div.relative")
	textareas[1].find_element(:css, 'textarea').send_keys " member text member text member text member text member text member text"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='facebook_page_cb']").click
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	
	#Twitter post
	puts "Member shares via Twitter"
	buttons[2].find_element(:css, 'a').click
	sleep(2)
    textareas[2].find_element(:css,  'textarea').send_keys " member text"
	sleep(1)
	
	#Face2face post
	puts "Member shares via Face2face"
	buttons[3].find_element(:css, 'a').click
	sleep(2)
	textareas[3].find_element(:css, 'textarea').send_keys "face2face member text face2face member text face2face member text face2face member text face2face member text"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='face2face_cb']").click
	
	#Upload photo to facebook post
	puts "Member shares via Upload to Facebook"
	buttons[4].find_element(:css, 'a').click
	sleep(2)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	uploads = @driver.find_elements(:xpath,'//input[@type="file"]')
	#@driver.find_element(:css, 'input[type="file"]').send_keys("C:\\Users\\Tripthi\\Pictures\\art.jpg") 
	uploads[0].send_keys("C:\\Users\\Tripthi\\Pictures\\snuggleFbPosts_09_14_hllwn.jpg")
	sleep(2)
	#post - validation of images
	#@driver.find_elements(:xpath, "//div[@id='facebook-warning-popup'][@class='modal.fade.in']/div/div[2]/button[1]").click
	#sleep(2)
	@driver.find_element(:css, "button.btn-color[sml-fill-text='Upload photo to facebook suggested Phrase']").click
	sleep(2)
	textareas[4].find_element(:css,'textarea').send_keys " member text member text member text member text member text member text"
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox[for='upload_photo_facebook_cb']").click
	sleep(2)
	
	#upload photo to twitter post
	puts "Member shares via Upload to Twitter"
	buttons[6].find_element(:css, 'a').click
	sleep(2)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	#@driver.find_element(:xpath, '//input[@type=""file""]').send_keys("C:\\Users\\Tripthi\\Pictures\\art.jpg")
	#buttons = @driver.find_elements(:css, "div.sharing-list-buttons")
	uploads[2].send_keys("C:\\Users\\Tripthi\\Pictures\\snuggleFbPosts_09_14_hllwn.jpg")
	sleep(3)
	textareas[6].find_element(:css,  'textarea').send_keys " member text"
	sleep(1)
	
	#Blog Review
	puts "Member shares via Blog"
	buttons[7].find_element(:css, 'a').click
	sleep(2)
	#textareas1 = @driver.find_elements(:css, "div.sharing-list-form")
	@driver.find_element(:css, "textarea[placeholder='Paste the link to your blog post here']").send_keys "http://blog.smiley360.com/"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='blog_cb']").click
	
	#Youtube
	puts "Member shares via Youtube"
	buttons[8].find_element(:css, 'a').click
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Paste the link to your video here']").send_keys "https://youtu.be/_UR-l3QI2nE"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='youtube_cb']").click
	
	#Pinterest
	puts "Member shares via Pinterest"
	buttons[9].find_element(:css, 'a').click
	sleep(2)
	textareas[7].find_element(:css,  'textarea').send_keys "https://www.pinterest.com/pin/457889487091108197/"
	sleep(5)
	@driver.find_element(:css, "label.control-checkbox[for='pinterest_cb']").click

	#Instagram
	puts "Member shares via Instagram"
	buttons[10].find_element(:css, 'a').click
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Please paste the link to your Instagram here']").send_keys "https://www.instagram.com/p/y4vf7rKSBQ/?taken-by=tripthi.shetty"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='instagram_cb']").click
	sleep(2)
	
	#Brand connect
	puts "Member shares via Brandconnect"
	buttons[11].find_element(:css, 'a').click
	sleep(2)
	textareas[8].find_element(:css,  'textarea').send_keys "Brand connect comment Brand connect comment Brand connect comment Brand connect comment"
	sleep(2)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	uploads[3].send_keys("C:\\Users\\Tripthi\\Pictures\\snuggleFbPosts_09_14_hllwn.jpg")
	sleep(3)
	
	#Retail Review Sharing 
	puts "Member shares via Retail Review"
	@driver.find_element(:css, 'a[ng-hide="services.retail_review.active"]').click
	sleep(2)
	#@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	uploads[4].send_keys("C:\\Users\\Tripthi\\Pictures\\snuggleFbPosts_09_14_hllwn.jpg")
	sleep(3)
	@driver.find_element(:css, "label.control-checkbox[for='retail_review_cb']").click
	
	#Email Invitation
	puts "Member shares via Email Invite"
	buttons[13].find_element(:css, 'a').click
	sleep(2)
	@driver.find_element(:css, 'input.sharing-list-field.new-name').clear
	@driver.find_element(:css, 'input.sharing-list-field.new-name').send_keys "Tripthi Shetty"
	sleep(1)
	@driver.find_element(:css, 'input.sharing-list-field.new-email').clear
	@driver.find_element(:css, 'input.sharing-list-field.new-email').send_keys "tripthi.testmember1@socialmedialink.com"
	sleep(1)
	@driver.find_element(:css, 'button.btn.btn-color.btn-block.add-button').click
	sleep(3)
	@driver.find_element(:css, "textarea[name='shares[][message]']").clear
	@driver.find_element(:css, "textarea[name='shares[][message]']").send_keys "Activity details with date time and location"
	sleep(1)
	#@driver.find_element(:css, "label.control-checkbox[for='email_group_invite_cb']").click
	sleep(1)
	
	#Bazaar Voice Sharing tool
	puts "Member shares via Bazaar Voice"
	buttons[14].find_element(:css, 'a').click
	sleep(2)
	@driver.find_element(:id,'shares__bazaarvoice_title').clear
	@driver.find_element(:id,'shares__bazaarvoice_title').send_keys "Bazzar Voice Title"
	sleep(2)
	@driver.find_element(:css,  "textarea[placeholder='Write your review here']").send_keys "Bazzar Voice review Bazzar Voice review  Bazzar Voice review  Bazzar Voice review"
	sleep(2)
	@driver.find_element(:xpath, "//div[@sml-rating='service.bazaarvoice.bazaarvoice_rating']/img[3]").click
	sleep(2)
	#@driver.find_element(:css,"label.control-checkbox[for='bazaarvoice_cb']").click
	sleep(2)
	
	#submit
	#@driver.find_element(:css, "button.btn-primary[type='submit']").click
	puts "Posting shares .."
	@driver.find_element(:xpath, "//button[@type='submit']").click
	#@driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	@driver.save_screenshot "Screenshots/sharingtools_posts.png"
	sleep(10)
	puts "All posts shared"
	
	
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = @driver.find_element(:xpath, "//div[@class='sidebar-score mobile-minimize']/h2").text
			assert_equal("Mission scores", welcomeText)

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