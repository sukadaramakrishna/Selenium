require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "SecurityTestAccessDenialToAnotherCommunity" do

  before(:each) do
	@config = YAML.load_file("config_smiley.yml")
    @config1 = YAML.load_file("config_multiplelogout.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @config['security']['base_url']
	@accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
	

  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_security_test_access_denial_to_another_community" do
    #Signin as an admin on multiple
	ary = Array.new 
	
	(0..12).each do |i|
	ary[i] = Selenium::WebDriver.for :firefox 
	#@driver[i] = Selenium::WebDriver.for :firefox 
	
	ary[i].get(@base_url + "/admins/sign_in")
	ary[i].find_element(:id, "admin_email").clear
    ary[i].find_element(:id, "admin_email").send_keys @config['security']['email']
	sleep(2)
    ary[i].find_element(:id, "admin_password").clear
    ary[i].find_element(:id, "admin_password").send_keys @config['security']['pass']
	sleep(2)
    ary[i].find_element(:name, "commit").click
	sleep(2)
	puts "Admin signed into Window #{i}" 
	#Trying to paginate to different pages 

	#ary[i].find_element(:css, @config1['url'][i]).click

	if i == 0
	ary[i].find_element(:css, "a.test-nav-members").click
	end
	if i == 1
	ary[i].find_element(:css, "a.test-nav-hubs").click
	end
	if i == 2
	ary[i].find_element(:css, "a.test-nav-groups").click
	end
	if i == 3
	#ary[i].find_element(:xpath, "(//a[@class='test-nav-config'])[0]").click
	ary[i].find_element(:link, "Reports").click
	end
	if i == 4
	#ary[i].find_element(:xpath, "(//a[@class='test-nav-config'])[1]").click
	ary[i].find_element(:link, "Administration").click
	end
	if i == 5
	#ary[i].find_element(:xpath, "(//a[@class='test-nav-config'])[1]").click
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Account").click
	end
	if i == 6
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Theme").click
	end
	if i == 7
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Settings").click
	end
	if i == 8
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Users").click
	end
	if i == 9
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Contact Information").click
	end
	if i == 10
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Assets").click
	end
	if i == 11
	ary[i].find_element(:link, "Administration").click
	sleep(1)
	ary[i].find_element(:link, "Home Page").click
	end
	if i == 12
	#Admin change password
	ary[i].find_element(:css, "button.topbar-menu-toggle.test-nav-user").click
	puts "reached after"
	sleep(2)
	ary[i].find_element(:css, "a.test-nav-profile").click
	sleep(2)
	ary[i].find_element(:xpath, "//div[@ng-model='admin.password']/div/div/input").click
	ary[i].find_element(:xpath, "//div[@ng-model='admin.password']/div/div/input").send_keys @config['security']['new_pass']
	sleep(2)
	ary[i].find_element(:xpath, "//div[@ng-model='admin.password_confirmation']/div/div/input").click
	ary[i].find_element(:xpath, "//div[@ng-model='admin.password_confirmation']/div/div/input").send_keys @config['security']['new_pass']
	sleep(2)
	ary[i].find_element(:xpath, "//button[@ng-click='save()']").click
	sleep(2)
	puts "Admin changed the password in Window 3"
	end
end

	(0..11).each do |i|
	#switch to the previous windows
	puts "Switch window"
	ary[i].get(@base_url + '/dashboard')
	sleep(2)
	if(ary[i].find_element(:css, "input.btn.btn-login.test-login-button").displayed?)
	puts "The login button is displayed which implies that the admin in window #{i} was forced to log out."
	sleep(2)
	else 
	puts "The login button is not displayed which implies that the admin in window #{i} was not forced to log out."
	end
end

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
