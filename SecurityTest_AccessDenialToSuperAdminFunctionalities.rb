require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "SecurityTestAccessDenialToAnotherCommunity" do

  before(:each) do
  @config = YAML.load_file("config_smiley.yml")
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
    #Signin as a super admin
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['security']['super_email']
	sleep(2)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['security']['super_pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	#Goto accounts page that only super admin has access
	@driver.get(@base_url + "/accounts")
	puts "Super admin accessed the accounts page"
	sleep(2)
	#Find the Logout button
	@driver.find_element(:css, "button.topbar-menu-toggle.test-nav-user").click
	sleep(2)
	#Super admin logs out
	@driver.find_element(:css, "a.test-nav-logout").click
	sleep(2)
	#Signin as a client admin
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['security']['email']
	sleep(2)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['security']['pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	#Goto accounts page that only super admin has access
	@driver.get(@base_url + "/accounts")
	sleep(2)
	#if(@driver.find_element(:xpath, "//title[contains(text(), '404')]").displayed?)
	if(@driver.find_element(:xpath, "//div/h1[contains(text(),'Page Not Found')]").displayed?)
	puts "The client admin could not access the accounts page which is a super admin functionality. Hence, the test was successful."
	else
	puts "The client admin could access the accounts page which is a super admin functionality. Hence, the test failed."
	sleep(2)
	#@driver.find_element(:xpath, "//h1[contains(text(), 'Page Not Found')]")
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
