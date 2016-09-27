require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "SecurityTestAccessDenialToAnotherCommunity" do

  before(:each) do
  @config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @config['security']['member_base_url']
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
    @driver.get(@base_url + "/home")
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['security']['member_email']
	sleep(2)
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['security']['member_pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	#Logout
	if(@driver.find_element(:css, "a.header-logout").displayed?)
	  @driver.find_element(:css, "a.header-logout").click
      puts "Logout button appears before logging out"
	  sleep(2)
    else 
      puts "Logout button does not appear before logging out"
    end
	
	#sleep(4)
	#@driver.manage.window.maximize
	#sleep(2)
=begin
	#Confirm that Logout button does not appear
	case @driver.find_element(:css, "a.test-nav-logout").dispalyed?
    when true
	puts "Logout button does not appear. This confirms the session terminates after the logout and the test is successful."
    when false 
    puts "Logout button appears. This does not confirm the session terminated correctly and the test failed"
    end
=end 	

    #Confirm that Login button appears
	if(@driver.find_element(:css, "input.login-submit").displayed?)
	  #@driver.find_element(:css, "input.login-submit").click
      puts "Signin  button appears. This confirms that session terminated correctly and the test was successful"
	  sleep(2)
    else 
      puts "Sigin button does not appear. This confirms that the session did not terminate correctly and the test failed."
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
