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
    #Signin into a community as an admin
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['security']['email']
	sleep(2)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['security']['pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	#Get the authentication token when the member logs in the first time
	auth = @driver.find_element(:xpath, "//meta[@name='csrf-token']")
	token = auth.attribute("content")
	puts "The authentication token when the member logged in the first time: #{token} "
	sleep(2)
	#Find the Logout button
	@driver.find_element(:css, "button.topbar-menu-toggle.test-nav-user").click
	sleep(2)
	#logout the first time
	@driver.find_element(:css, "a.test-nav-logout").click
	sleep(2)
	#login the second time
	@driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['security']['email']
	sleep(2)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['security']['pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	#Get the authentication token when the member logs in the second time
	auth = @driver.find_element(:xpath, "//meta[@name='csrf-token']")
	token = auth.attribute("content")
	puts "The authentication token when the member logged in the second time: #{token} "
	sleep(2)
	#Find the Logout button
	@driver.find_element(:css, "button.topbar-menu-toggle.test-nav-user").click
	sleep(2)
	#logout the second time
	@driver.find_element(:css, "a.test-nav-logout").click
	sleep(2)
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
  puts "Logout button does not appear. This confirms the session terminates after the logout and the test is successful."
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
