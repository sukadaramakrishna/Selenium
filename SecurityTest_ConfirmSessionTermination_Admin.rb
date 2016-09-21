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
	#Find the Logout button
	@driver.find_element(:css, "button.topbar-menu-toggle.test-nav-user").click
	sleep(2)
	if(@driver.find_element(:css, "a.test-nav-logout").displayed?)
	  @driver.find_element(:css, "a.test-nav-logout").click
      puts "Logout button appears before logging out"
	  sleep(2)
    else 
      puts "Logout button does not appear before logging out"
    end
	
	sleep(4)
	@driver.manage.window.maximize
	sleep(2)

	#Confirm that Logout button does not appear
	if(@driver.find_element(:css, "a.test-nav-logout").size < 0)
      puts "Logout button does not appear. This confirms the session terminates after the logout and the test is successful."
	  sleep(2)
    else 
      puts "Logout button appears. This does not confirm the session terminated correctly and the test failed"
    end
	
=begin
    #Confirm that Login button appears
	if(@driver.find_element(:css, "input.btn.btn-login.test-login-button").displayed?)
	  @driver.find_element(:css, "input.btn.btn-login.test-login-button").click
      puts "Login button appears. This confirms that session terminated correctly and the test was successful"
	  sleep(2)
    else 
      puts "Login button does not appear. This confirms that the session did not terminate correctly and the test failed."
    end
=end 
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
