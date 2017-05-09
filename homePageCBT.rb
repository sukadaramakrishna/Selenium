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
			#@base_member_url = @config['member']['base_url']
			username = 'tripthi.shetty%40socialmedialink.com'
			authkey = 'u283c7d7d4fafeb7'

			caps = Selenium::WebDriver::Remote::Capabilities.new
			#caps['selenium-version'] = "2.53.4"
			caps["name"] = "Home page templates verification"
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

			
			cbt_api.createTemplate1()
			puts "Template 1 Saved and tested"
			cbt_api.createTemplate2()
			puts "Template 2 saved and tested"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				$driver.find_element(:xpath, "//div[@class='mlogic-title ng-binding']")
			}
=end
			# adding pass fail condition
			welcomeText = $driver.find_element(:xpath, "//div[@class='hidden-xs']/p").text
			assert_equal("Don't have an account?", welcomeText)

			puts "Passed Test"
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
	def createTemplate1()
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
		$driver.find_element(:link, "Administration").click
		sleep(4)
		$driver.find_element(:link, "Home Page").click
		sleep(4)
		$driver.find_element(:xpath, "//textarea[@ng-model='theme.welcome_text']").click
		$driver.find_element(:xpath, "//textarea[@ng-model='theme.welcome_text']").send_keys "Join now and get connected with all®!Welcome text template edited"
		sleep(2)
		e = $driver.find_element(:css, "input.background-field[type='file']")
		e.send_keys("C:\\Users\\Tripthi\\Pictures\\Home Page\\sevgen.png")
		sleep(6)
		puts "Uploaded background image"
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[3]/div[2]/input").clear
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[3]/div[2]/input").send_keys "#3729d9"
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[4]/div[2]/input").clear
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[4]/div[2]/input").send_keys "#d6e33d"
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[5]/div[2]/input").clear
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[5]/div[2]/input").send_keys "#395bd4"
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[6]/div[2]/input").clear
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[6]/div[2]/input").send_keys "#e65757"
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[7]/div[2]/input").clear
		sleep(1)
		$driver.find_element(:xpath, "(//div[@class='survey-sidebar-option'])[7]/div[2]/input").send_keys "#3bedd9"
		sleep(1)
		puts "Colors set"
		$driver.find_element(:xpath, "(//label[@class='font-selector-button']/small)[2]").click
		sleep(1)
		puts "Arial Font selected"
		#scroll
		$driver.execute_script("scroll(0, 0);")
		sleep(4)
		#Preview before saving
		$driver.find_element(:xpath, "//a[@class='btn btn-cancel']").click
		sleep(2)
		puts "Clicked Preview before saving the template"
		$driver.switch_to.window($driver.window_handles[1])
		sleep(1)
		$driver.save_screenshot "Screenshots/previewTemplate1.png" 
		puts "Screen shot of the preview before saving the template saved"
		#Confirm on the member page that the template has not saved
		puts "Redirecting to member page to confirm if the template is not saved"
		sleep(4)
		$driver.navigate.to($config['member']['base_url']	+ "/home")
		sleep(4)
		$driver.save_screenshot "Screenshots/previewMemberSideConfirmNotSaved.png" 
		#Redirect back to admin side and save template 1
		sleep(2)
		$driver.switch_to.window($driver.window_handles[0])
		sleep(2)
		#Redirecting to admin side and saving the edits made to the template 1
		$driver.find_element(:xpath, "//a[@class='btn btn-default']").click
		sleep(2)
		puts "Redirected to the admin side and saved the edits made to template 1"
		$driver.switch_to.window($driver.window_handles[1])
		sleep(2)
		$driver.navigate.to($config['member']['base_url']	+ "/home")
		sleep(4)
		$driver.save_screenshot "Screenshots/previewMemberSideToConfirmSaved.png" 
		sleep(2)
	end
	def createTemplate2()
	sleep(2)
	$driver.switch_to.window($driver.window_handles[0])
	puts "Switched to admin to create template 2"
	sleep(2)
	$driver.find_element(:xpath, "//ul[@class='homepage-layout']/li[2]").click
	sleep(3)
	$driver.find_element(:xpath, "//div[@ng-model='theme.brand_name']").click
	sleep(1)
	$driver.find_element(:xpath, "//div[@ng-model='theme.brand_name']").send_keys "Headline template 2"
	puts "Headline updated"
	sleep(1)
	$driver.find_element(:xpath, "//textarea[@ng-model='theme.description']").click
	sleep(1)
	$driver.find_element(:xpath, "//textarea[@ng-model='theme.description']").send_keys "Template 2 description Template 2 description Template 2 description Template 2 description Template 2 description"
	puts "Description of template 2 edited"
	sleep(1)
	#Adding first media tile to template 2
	puts "Adding first media tile to template 2"
	$driver.find_element(:xpath, "(//div[@class='text-center'])[1]/button[1]").click
	sleep(2)
	e = $driver.find_element(:css, "input.image-field[type='file']")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Home Page\\funny-monkey-11.jpg")
	sleep(6)
	puts "Uploaded media tile 1"
	$driver.find_element(:xpath, "(//div[@class='homepage-item-button']/button[2])[1]").click
	sleep(2)
	#Adding second media tile to template 2
	puts "Adding second media tile to template 2"
	$driver.find_element(:xpath, "(//div[@class='text-center'])[2]/button[2]").click
	sleep(2)
	$driver.find_element(:xpath, "//div[@ng-switch-when='video']/div/div[2]/input").send_keys "https://www.youtube.com/watch?v=_UR-l3QI2nE"
	sleep(2)
	puts "Uploaded video media tile 2"
	$driver.find_element(:xpath, "//div[@ng-switch-when='video']/div/div[3]/input").send_keys "Tile 2 heading"
	sleep(2)
	puts "added tile 2 heading"
	$driver.find_element(:xpath, "//div[@ng-switch-when='video']/div/div[4]/input").send_keys "Tile 2 description"
	sleep(2)
	puts "added tile 2 description"
	$driver.find_element(:xpath, "(//div[@class='homepage-item-button']/button[2])[2]").click
	sleep(2)
	#Adding third media tile to template 2
	puts "Adding third media tile to template 2"
	$driver.find_element(:xpath, "(//div[@class='text-center'])[3]/button[3]").click
	sleep(2)
	$driver.find_element(:xpath, "//input[@placeholder='Link to article']").send_keys "https://blog.smiley360.com/"
	sleep(2)
	puts "added link media tile 3"
	$driver.find_element(:xpath, "//input[@placeholder='Short description']").send_keys "Short description media tile 3"
	puts "added short description media tile 3"
	sleep(2)
	e = $driver.find_element(:xpath, "(//input[@class='image-field'])[2]")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Home Page\\rabbit.jpg")
	sleep(6)
	puts "Uploaded media tile 3"
	$driver.find_element(:xpath, "(//div[@class='homepage-item-button']/button[2])[3]").click
	sleep(2)
	#Adding fourth media tile to template 2
	puts "Adding fourth media tile to template 2"
	$driver.find_element(:xpath, "(//div[@class='text-center'])[4]/button[1]").click
	sleep(2)
	e = $driver.find_element(:xpath, "(//input[@class='image-field'])[3]")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Home Page\\funnymonk1.jpg")
	sleep(6)
	puts "Uploaded media tile 3"
	$driver.find_element(:xpath, "(//div[@class='homepage-item-button']/button[2])[4]").click
	sleep(2)
	#Adding fifth media tile to template 2
	puts "Adding fifth media tile to template 2"
	$driver.find_element(:xpath, "(//div[@class='text-center'])[5]/button[1]").click
	sleep(2)
	e = $driver.find_element(:xpath, "(//input[@class='image-field'])[4]")
	e.send_keys("C:\\Users\\Tripthi\\Pictures\\Home Page\\funnymonk3.jpg")
	sleep(6)
	puts "Uploaded media tile 3"
	$driver.find_element(:xpath, "(//div[@class='homepage-item-button']/button[2])[5]").click
	sleep(2)
	#scroll
	$driver.execute_script("scroll(0, 0);")
	sleep(4)
	#Preview before saving
	$driver.find_element(:xpath, "//a[@class='btn btn-cancel']").click
	sleep(2)
	puts "Clicked Preview before saving the template 2"
	$driver.switch_to.window($driver.window_handles[2])
	sleep(1)
	$driver.save_screenshot "Screenshots/previewTemplate2.png" 
	puts "Screen shot of the preview before saving the template 2 saved"
	#Confirm on the member page that the template 2 has not saved
	puts "Redirecting to member page to confirm if the template 2 is not saved"
	sleep(4)
	$driver.navigate.to($config['member']['base_url']	+ "/home")
	sleep(4)
	$driver.save_screenshot "Screenshots/previewMemberSideConfirmNotSavedTemplate2.png" 
	#Redirect back to admin side and save template 2
	sleep(2)
	$driver.switch_to.window($driver.window_handles[0])
	sleep(2)
	#Redirecting to admin side and saving the edits made to the template 2
	$driver.find_element(:xpath, "//a[@class='btn btn-default']").click
	sleep(2)
	puts "Redirected to the admin side and saved the edits made to template 2"
	$driver.switch_to.window($driver.window_handles[1])
	sleep(2)
	$driver.navigate.to($config['member']['base_url']	+ "/home")
	sleep(4)
	$driver.save_screenshot "Screenshots/previewMemberSideToConfirmSavedTempalte2.png" 
	sleep(2)
	end
end