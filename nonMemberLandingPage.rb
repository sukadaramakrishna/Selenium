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
			$config = YAML.load_file("config_smiley.yml")
			$base_url = $config['admin']['base_url']
			$name = $config['signup']['first_name'] + "." +$config['signup']['last_name']
			$email = $name + "@yopmail.com"
			$pass = $config['member']['pass']
			$zip = $config['signup']['zip']
			$first_name = $config['signup']['first_name']
			$last_name = $config['signup']['last_name']
			#@base_member_url = @config['member']['base_url']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new
			#caps['selenium-version'] = "2.53.4"
			caps["name"] = "Non member landing page verification"
			caps["build"] = "1.0"
			caps["browser_api_name"] = "Chrome58x64"
            caps["os_api_name"] = "Win7x64-C1"
			caps["screen_resolution"] = "1366x768"
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

			
			cbt_api.createActivityWithLandingPage()
			puts "Wating for the offers to be offered"
			sleep(60)
			cbt_api.viewNonMemberLandingPage()
			cbt_api.signUpViaLandingPage()
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				$driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = $driver.find_element(:xpath, "//a[@class='active test-hub-nav-overview']").text
			assert_equal("Overview", welcomeText)

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
	def createActivityWithLandingPage()
	puts "Loading URL"
			$driver.navigate.to($config['admin']['base_url']	+ "/admins/sign_in")
			# start login process by entering username
			puts "Entering username"
			$driver.find_element(:id, "admin_email").send_keys $config['admin']['email']

			# then we'll enter the password
			puts "Entering password"
			$driver.find_element(:id, "admin_password").send_keys $config['admin']['pass']

			# then we'll click the login button
			puts "Logging in"
			$driver.find_element(:name, "commit").click
			sleep(2)
			puts "Creating new mission hub"
			
			$driver.find_element(:link, "Mission Hubs").click
	sleep(4)
    $driver.find_element(:link, "New Mission Hub").click
	sleep(4)
    $driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    $driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Landing Page Test"
	sleep(2)
	$driver.find_element(:css, "button.btn-default").click
	sleep(2)
	$driver.find_element(:css, "li.test-hub-new-promo").click
	sleep(5)
	#Creating landing page content
	$driver.find_element(:link, "Landing Page").click
	sleep(4)
	puts "Adding landing page title"
	$driver.find_element(:xpath, "//textarea[@placeholder='Title']").click
	$driver.find_element(:xpath, "//textarea[@placeholder='Title']").send_keys "Landing page title goes here"
	sleep(2)
	puts "Adding landing page text"
	$driver.find_element(:xpath, "//textarea[@placeholder='Text']").click
	$driver.find_element(:xpath, "//textarea[@placeholder='Text']").send_keys "Landing page text goes here"
	sleep(2)
	puts "Toggling Tagline"
    $driver.find_element(:id, "switch_cb_promo_page.show_tagline").click
	sleep(4)
	puts "Adding tagline text"
	$driver.find_element(:xpath, "//textarea[@placeholder='Tagline']").click
	$driver.find_element(:xpath, "//textarea[@placeholder='Tagline']").send_keys "Landing page tagline text goes here"
	sleep(2)
	puts "Uploading image"
    $driver.find_element(:id, "switch_cb_promo_page.show_image").click
	sleep(4)
	e = $driver.find_element(:css, "input.js-description-image-field[type='file']")
	#((RemoteWebElement) e ).setFileDetector(new LocalFileDetector())
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
    sleep(8)
	$driver.find_element(:xpath, "//button[@class='btn btn-sidebar btn-primary w100 test-question-save']").click
	sleep(2)
	$driver.find_element(:link, "Landing Page Test").click
	sleep(4)
	$driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
	puts "Creating new activity"
    $driver.find_element(:link, "New Activity").click
	sleep(7)
    $driver.find_element(:css, "button.btn-edit").click
	sleep(3)
	$driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	$driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Landing Page Test Activity"
	sleep(4)
    $driver.find_element(:css, "textarea.mission-page-title").clear
	sleep(1)
    $driver.find_element(:css, "textarea.mission-page-title").send_keys "Landing Page Test Activity"
	sleep(2)
	puts "Adding goal to the activity"
	$driver.find_element(:css, "input.mission-goal").clear
	$driver.find_element(:css, "input.mission-goal").send_keys "10"
	
	#scroll
	sleep(1)
	$driver.execute_script("scroll(0, 250);")
	sleep(4)

	#Toggle Share A Link
	puts "Toggling Share A Link"
	$driver.find_element(:id, "switch_cb_share_link").click
	sleep(1)
	#$driver.find_element(:css, "input.activity-share-url[ng-model='activity.share_link.seed_url']").send_keys "http://www.google.com/"
	$driver.find_element(:xpath, "//div[@id='share_link']").click
	sleep(2)
	$driver.find_element(:xpath, "//div[@id='share_link']/input").click
	sleep(2)
	$driver.find_element(:xpath, "//div[@id='share_link']/input").send_keys(:arrow_down)
	sleep(2)
	$driver.find_element(:xpath, "//div[@id='share_link']/input").send_keys(:enter)
	sleep(2)

	#drop = $driver.find_element(:id, "select2-results-3")
	#drop.find_element(:css,"li.select2-results-dept-0.select2-result.select2-result-selectable.select2-highlighted").click
	sleep(2)
	
	#scroll
	$driver.execute_script("scroll(0,1500);")
	sleep(4)
	
	#save
	puts "Saving.."
    $driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	puts "Saved all settings"

	#Mission logic section
	$driver.find_element(:link, "Landing Page Test").click
	sleep(3)
	puts "Redirecting to mission logic page"
    $driver.find_element(:link, "Mission Logic").click
	sleep(3)
    $driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	puts "Setting up the start and end date"
	$driver.find_element(:id, "date-start").click
	#$driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	$driver.find_element(:xpath, "//td[@class='active day']/preceding-sibling::td[@class='day'][1]").click
	puts "Adding group"
	$driver.find_element(:css, "button.mlogic-add-group").click
	#$driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2575']").click
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
	puts "Saving.."
	$driver.find_element(:css, "button.test-hub-logic-save").click
	puts "Saved settings"
	sleep(2)
	end
	
	def viewNonMemberLandingPage()
	puts "Loading URL"
	$driver.navigate.to($config['member']['base_url']	+ "/home")
	# start login process by entering username
	puts "Entering username"
	$driver.find_element(:id, "member_email").send_keys $config['member']['email']

	# then we'll enter the password
	puts "Entering password"
	$driver.find_element(:id, "member_password").send_keys $config['member']['pass']

	# then we'll click the login button
	puts "Logging in"
	$driver.find_element(:name, "commit").click
	sleep(4)
	#Accept activity
	puts "Accept an activity"
	$driver.find_element(:link, "Dashboard").click
	sleep(2)
	$driver.find_element(:link, "Landing Page Test Activity").click
	sleep(2)
	$driver.find_element(:xpath, "//*[contains(text(), 'Accept')]").click
	sleep(1)
	$driver.find_element(:css,"input.btn.btn-color.btn-lg.btn-block").click
	sleep(2)
	#Copy and paste share a link 
	abc = $driver.find_element(:xpath, "//input[@class='sharing-list-field']").attribute('value') 
	#abc = Clipboard.data
	puts "vbvb"
	puts abc
	$driver.navigate.to(abc)
	sleep(4)
	$driver.save_screenshot "Screenshots/viewNonMemberLandingPage.png" 
	sleep(1)
	puts "Viewed the landing page"
	$driver.navigate.to($config['member']['base_url']	+ "/home")
	sleep(2)
	$driver.find_element(:link, "Dashboard").click
	sleep(2)
    $driver.find_element(:link, "Landing Page Test Activity").click
	sleep(2)
	$driver.save_screenshot "Screenshots/shareLinkConfirmMemberScore.png" 
	end
	
	def signUpViaLandingPage()
	sleep(2)
	abc = $driver.find_element(:xpath, "//input[@class='sharing-list-field']").attribute('value') 
	#abc = Clipboard.data
	puts "vbvb"
	puts abc
	sleep(2)
	$driver.find_element(:xpath, "//a[@class='header-logout']").click
	sleep(5) 
	$driver.navigate.to(abc)
	sleep(4)
	$driver.find_element(:xpath, "//a[@class='btn btn-color btn-banner']").click
	sleep(4)
	$driver.find_element(:xpath, "//button[@class='login-switch-button']").click
	sleep(2)
	sleep(2)
	$driver.find_element(:xpath, "(//input[@id='member_email'])[2]").click
    $driver.find_element(:xpath, "(//input[@id='member_email'])[2]").clear
    $driver.find_element(:xpath, "(//input[@id='member_email'])[2]").send_keys $email
	sleep(2)
    $driver.find_element(:xpath, "(//input[@id='member_password'])[2]").clear
    $driver.find_element(:xpath, "(//input[@id='member_password'])[2]").send_keys $pass
    sleep(2)
	#$driver.find_element(:css, "label.control-checkbox").click
	sleep(1)
    $driver.find_element(:css, "span").click
    $driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
	sleep(2)
	$driver.get("http://yopmail.com");
	sleep(4)
	$driver.find_element(:id, "login").click
    $driver.find_element(:id, "login").clear
    $driver.find_element(:id, "login").send_keys $name
    $driver.find_element(:css, "input.sbut").click
	sleep(1)
	puts 'switching to internal iframe'
	$driver.switch_to.frame('ifmail')
	sleep(1)
    @href = $driver.find_element(:link, "CONFIRM ACCOUNT").attribute('href')
	puts 'activation link: '+@href
	$driver.get(@href)
	sleep(2)
    $driver.find_element(:id, "member_first_name").clear
    $driver.find_element(:id, "member_first_name").send_keys $first_name
	sleep(2)
    $driver.find_element(:id, "member_last_name").clear
    $driver.find_element(:id, "member_last_name").send_keys $last_name
	sleep(2)
    $driver.find_element(:id, "member_zip_code").clear
    $driver.find_element(:id, "member_zip_code").send_keys $zip
    Selenium::WebDriver::Support::Select.new($driver.find_element(:id, "date_month")).select_by(:text, "February")
	sleep(1)
    Selenium::WebDriver::Support::Select.new($driver.find_element(:id, "date_day")).select_by(:text, "7")
	sleep(1)
    Selenium::WebDriver::Support::Select.new($driver.find_element(:id, "date_year")).select_by(:text, "1991")
	sleep(3)
    $driver.find_element(:xpath, "(//label[@class='control-radio'])[1]").click
	sleep(2)
    $driver.find_element(:name, "commit").click
	$driver.save_screenshot "Screenshots/tutorial.png"
	$driver.find_element(:css, "a.btn.btn-color.btn-lg").click
	sleep(2)
	$driver.navigate.to($config['admin']['base_url']	+ "/admins/sign_in")
			# start login process by entering username
			puts "Entering username"
			$driver.find_element(:id, "admin_email").send_keys $config['admin']['email']

			# then we'll enter the password
			puts "Entering password"
			$driver.find_element(:id, "admin_password").send_keys $config['admin']['pass']

			# then we'll click the login button
			puts "Logging in"
			$driver.find_element(:name, "commit").click
			sleep(2)
			$driver.find_element(:link, "Mission Hubs").click
	sleep(4)
	$driver.find_element(:link, "Landing Page Test").click
	sleep(4)
	$driver.save_screenshot "Screenshots/newMemberGainedMetricOverviewPage.png" 
	sleep(2)
	end
end