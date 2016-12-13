require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations
#require "win32/clipboard"
#include Win32 

describe "Sharing Tools" do

  before(:each) do
	@config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @config['admin']['base_url']
	@base_member_url = @config['member']['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
   after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_sharing_tools" do
	#login()	
	#sharing_activity()
	admin_login()
	DAR_part1()
	
  end
  

  
  def login()
	@driver.get(@config['member']['base_url']	+ "/home")
    #@driver.find_element(:link, "or your email address").click
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(5)
	@driver.manage.window.maximize
	sleep(2)
	@driver.save_screenshot "Screenshots/dashboard.png"
	end

	def sharing_activity()
	@driver.find_element(:link, "Sharing Tools Activity").click
	sleep(2)
	
	buttons = @driver.find_elements(:css, "div.sharing-list-buttons")	
	@driver.execute_script("scroll(0, 300);")
	sleep(4)
	textareas = @driver.find_elements(:css, "div.relative")
	#Face2face post
	buttons[3].find_element(:css, 'a').click
	sleep(2)
	textareas[3].find_element(:css, 'textarea').send_keys "face2face member text face2face member text face2face member text face2face member text face2face member text"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='face2face_cb']").click
	
	@driver.execute_script("scroll(0, 300);")
	sleep(4)
	
	#Blog Review
	buttons[7].find_element(:css, 'a').click
	sleep(2)
	#textareas1 = @driver.find_elements(:css, "div.sharing-list-form")
	@driver.find_element(:css, "textarea[placeholder='Paste the link to your blog post here']").send_keys "http://blog.smiley360.com/"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='blog_cb']").click
	
	#submit
	#@driver.find_element(:css, "button.btn-primary[type='submit']").click
	@driver.find_element(:xpath, "//button[@type='submit']").click
	#@driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	@driver.save_screenshot "Screenshots/sharingtools_posts.png"
	sleep(10)	
	
	#logout
	@driver.find_element(:css, "a.header-logout").click
	sleep(1)
    end
	
	def admin_login()
	@driver.get(@config['admin']['base_url']	+ "/admins/sign_in")
    #@driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
	sleep(1)
    @driver.find_element(:name, "commit").click
	sleep(4)
	@driver.manage.window.maximize
	end
	
	def DAR_part1()
	#click mission hubs
	@driver.find_element(:link, "Mission Hubs").click
	sleep(4)
	#click 'sharing tools' activity
	@driver.find_element(:link, "Sharing Tools").click
	sleep(3)
	#take screen shot of the activity overview page
	@driver.save_screenshot "Screenshots/activityOverviewPage.png"
	sleep(2)
	#click activity analytics
	@driver.find_element(:css, "a.mission-item-analytics-link").click
	sleep(3)
	#auto fill team section
	@driver.find_element(:css, "input.js-autocomplete.ui-autocomplete-input").click
	@driver.find_element(:xpath, "//c-your-team[@class='ng-isolate-scope ng-pristine ng-valid']/div[1]/c-admin-select/input").click
	sleep(2)
	@driver.find_element(:xpath, "//ul[@id='ui-id-1']/li").click
	sleep(2)
	#Toggle Bench marks
	@driver.find_element(:id, "switch_cb_ctrl.report.benchmarks_enabled").click
	sleep(4)
	#Fill mission clicks number
	@driver.find_element(:xpath, "//input[@placeholder='Mission Clicks Number']").clear
	@driver.find_element(:xpath, "//input[@placeholder='Mission Clicks Number']").send_keys "100"
	sleep(2)
	#Fill impression number
	@driver.find_element(:xpath, "//input[@placeholder='Impressions Number']").clear
	@driver.find_element(:xpath, "//input[@placeholder='Impressions Number']").send_keys "100"
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	#Fill all the Benchmarks
	@driver.find_element(:xpath, "(//div[@class='analytics-databox'])[4]/input").clear
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='analytics-databox'])[4]/input").send_keys "100"
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='analytics-databox'])[5]/input").clear
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='analytics-databox'])[5]/input").send_keys "100"
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='analytics-databox'])[6]/input").clear
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='analytics-databox'])[6]/input").send_keys "100"
	
	#scroll
	@driver.execute_script("scroll(0, 600);")
	sleep(4)
	
	#Fill Mission highlights section
	@driver.find_element(:xpath, "//c-mission-highlights/input[1]").clear
	@driver.find_element(:xpath, "//c-mission-highlights/input[1]").send_keys "Mission highlights heading"
	sleep(4)
	#scroll
	@driver.execute_script("scroll(0, 650);")
	sleep(4)
	@driver.find_element(:xpath, "//div[@ng-model='report.mission_highlights.highlights']").clear
	@driver.find_element(:xpath, "//div[@ng-model='report.mission_highlights.highlights']").send_keys "Mission highlights mission highlights mission highlights"
	sleep(4)
	#scroll
	@driver.execute_script("scroll(0, 600);")
	sleep(4)
	@driver.find_element(:xpath, "//input[@placeholder='Mission hashtag']").clear
	@driver.find_element(:xpath, "//input[@placeholder='Mission hashtag']").send_keys "missionhighlights"
	sleep(4)
	@driver.find_element(:xpath, "//div[@ng-model='report.mission_highlights.highlights']").clear
	@driver.find_element(:xpath, "//div[@ng-model='report.mission_highlights.highlights']").send_keys "Mission highlights mission highlights mission highlights"
	sleep(4)
	
	#save_screenshot
	@driver.find_element(:xpath, "//div[@class='survey-sidebar-content'][4]").click
	sleep(2)
	
	#Take screen shot of the activity analytics
	@driver.save_screenshot "Screenshots/activityAnalytics.png"
	sleep(10)	
	end
  
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
    alert.accept()
    else
    alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
