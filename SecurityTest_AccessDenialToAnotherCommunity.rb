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
	#Goto Adminstration -> Accounts
    @driver.find_element(:link, "Administration").click
	sleep(1)
    @driver.find_element(:link, "Account").click
	sleep(2)
	#Admin tries to log into another community
	@driver.get(@base_url + "/accounts/485")
	puts "Admin tried to login to another community."
	sleep(2)
	@driver.find_element(:xpath, "//title[contains(text(), '404')]")
	sleep(2)
	@driver.find_element(:xpath, "//h1[contains(text(), 'Page Not Found')]")
	sleep(2)
	puts "The admin could not access another community. Hence, the test was successful."
	
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
