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

			caps["name"] = "Admin settings"
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
			@driver.navigate.to(@base_url + "/admins/sign_in")
			#@driver.get(@base_url + "/home")
			
			puts "Entering member email"
			@driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
	puts "Entering member password"
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
	puts "Logging in"
    @driver.find_element(:name, "commit").click
	sleep(5)
	
	puts "Click the administration section"
	@driver.find_element(:link, "Administration").click
	sleep(1)
    @driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	sleep(1)
	puts "Add max points"
    @driver.find_element(:xpath, "(//input[@type='number'])[1]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[1]").send_keys "10"
	sleep(1)
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[2]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[2]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[3]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[3]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[4]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[4]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[5]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[5]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[6]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[6]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[7]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[7]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[8]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[8]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[9]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[9]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[10]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[10]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[11]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[11]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[12]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[12]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[13]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[13]").send_keys "10"
	sleep(1)
	 @driver.find_element(:xpath, "(//input[@type='number'])[14]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[14]").send_keys "10"
	sleep(1)
	 @driver.find_element(:xpath, "(//input[@type='number'])[15]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[15]").send_keys "10"
	sleep(1)
	 @driver.find_element(:xpath, "(//input[@type='number'])[16]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[16]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[17]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[17]").send_keys "10"
	sleep(1)
	puts "Add points per share"
	@driver.find_element(:xpath, "(//input[@type='number'])[18]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[18]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[19]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[19]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[22]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[22]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[24]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[24]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[25]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[25]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[26]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[26]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[27]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[27]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[28]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[28]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[29]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[29]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[31]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[31]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[32]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[32]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[33]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[33]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[34]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[34]").send_keys "5"
	sleep(1)
	puts "Add profile completion points"
    @driver.find_element(:xpath, "(//input[@type='number'])[35]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[35]").send_keys "100"
	sleep(2)

	#Social Media Pages
	#@driver.find_element(:xpath, "(//input[@type='checkbox'])[0]").click
	puts "Toggling Social Media Pages "
	@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div[2]/input").send_keys "Smiley360"
	sleep(1)
	#@driver.find_element(:xpath, "(//input[@type='checkbox'])[1]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[2]/input").send_keys "Smiley360"
	sleep(1)
    #@driver.find_element(:xpath, "(//input[@type='checkbox'])[2]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[3]/div[2]/div/div[2]/input").send_keys "Smiley360"
	sleep(1)
    #@driver.find_element(:xpath, "(//input[@type='checkbox'])[3]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[4]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[4]/div[2]/div/div[2]/input").send_keys "MySmiley360"
	sleep(1)

	#scroll
	sleep(1)
	@driver.execute_script("scroll(0,1000);")
	sleep(4)
	puts "scrolled"
	
	#cookie notification
	puts "Enable cookie notification"
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[4]").click
	sleep(1)
	puts "after cookie notification toggle on"
	
	#Features section
    #Brand connect Toggle
	puts "Toggling Brand connect"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[5]").click
	sleep(2)
	puts "after bc toggle input toggled on"
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.custom_brand_connect_name.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.custom_brand_connect_name.value']").send_keys "Brand Connect"
	sleep(1)
	#Tutorial Toggle
	puts "Toggling Tutorial"
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[6]").click
	sleep(2)
	#Welcome Email Toggle
	puts "Toggling welcome email and mission emails"
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[7]").click
	sleep(2)
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.welcome_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.welcome_email.value']").send_keys "welcome"
	sleep(1)
	#Mission Acceptance Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[8]").click
	sleep(2)
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_acceptance_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_acceptance_email.value']").send_keys "mission-acceptance"
	sleep(1)
	#Mission Completion Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[9]").click
	sleep(2)
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_completion_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_completion_email.value']").send_keys "mission-complete-dev"
	sleep(1)
	#Post Acceptance Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[10]").click
	sleep(2)
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_accepted_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_accepted_email.value']").send_keys "activity-accepted"
	sleep(1)
	#Post Decline Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[11]").click
	sleep(2)
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_declined_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_declined_email.value']").send_keys "activity-declined"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[12]").click
	sleep(2)
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 1300);")
	sleep(4)

	#Blog
	puts "Toggling Blog"
	@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").send_keys "http://blog.smiley360.com/"
	sleep(1)
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").send_keys "Blog"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[13]").click
	sleep(2)
	#FAQ
	puts "Toggling FAQ"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").send_keys "http://smiley360.helpscoutdocs.com/"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").send_keys "FAQ"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[14]").click
	sleep(2)
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 0);")
	sleep(4)
	
	#age
	puts "Adding age requirements"
	@driver.find_element(:xpath, "//div[@class='group-box'][2]/div[1]/div[1]/div/div[1]/div/input[@ng-model='value.value']").clear
	@driver.find_element(:xpath, "//div[@class='group-box'][2]/div[1]/div[1]/div/div[1]/div/input[@ng-model='value.value']").send_keys "13"
	sleep(2)
	

	#Email Preferences
	puts "Adding email preferences"
	sleep(2)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[15]").click
	sleep(2)
	puts "after toggling on email preferences"
	puts "stops here"
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 400);")
	sleep(4)
	puts "scrolls"
=begin
	@driver.find_element(:xpath, "//body[@id='admin']/div[1]/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").clear
	sleep(1)
    @driver.find_element(:xpath, "//body[@id='admin']/div[1]/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").send_keys "Twitter Parties"
	sleep(1)
    @driver.find_element(:css, "button.btn.btn-draggable-add").click
	sleep(2)
    @driver.find_element(:xpath, "//body[@id='admin']/div[1]/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div[1]/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").send_keys "Special Promotions"
    @driver.find_element(:css, "button.btn.btn-draggable-add").click
=end	
	#Member Flags
	puts "Adding member Flags"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div/div/input").send_keys "Member Flag1"
	sleep(2)
    @driver.find_element(:css, "div.member-flag-edit > button.btn.btn-draggable-add").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div[2]/div/input").send_keys "Member Flag 2"
	sleep(2)
	@driver.find_element(:css, "div.member-flag-edit > button.btn.btn-draggable-add").click
	sleep(1)
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 0);")
	sleep(4)
	
	#Save
	puts "Saving .."
	@driver.find_element(:css, "a.btn.btn-default[ng-click='save()']").click
	sleep(1)
	puts "Administration settings saved"
=begin
			# let's wait here to ensure that the page is fully loaded before we move forward
			wait = Selenium::WebDriver::Wait.new(:timout => 10)
			wait.until {
				@driver.find_element(:css, "a.btn.btn-color.btn-sidebar-profile")
			}
=end
			# if we passed the login, then we should see some welcomeText
			welcomeText = @driver.find_element(:xpath, "//div[@class='page-header']/h1").text
			assert_equal("Administration", welcomeText)

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