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
    #Signin as an admin on Window 1
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['security']['email']
	sleep(2)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['security']['pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	puts "Admin signed into Window 1"
	#Signin as an admin on Window 2
	@driver_new = Selenium::WebDriver.for :firefox 
	@driver_new.get(@base_url + "/admins/sign_in")
	@driver_new.find_element(:id, "admin_email").clear
    @driver_new.find_element(:id, "admin_email").send_keys @config['security']['email']
	sleep(2)
    @driver_new.find_element(:id, "admin_password").clear
    @driver_new.find_element(:id, "admin_password").send_keys @config['security']['pass']
	sleep(2)
    @driver_new.find_element(:name, "commit").click
	sleep(2)
	puts "Admin signed into Window 2"
	#change password
	@driver_new.find_element(:css, "button.topbar-menu-toggle.test-nav-user").click
	sleep(2)
	@driver_new.find_element(:css, "a.test-nav-profile").click
	sleep(2)
	@driver_new.find_element(:xpath, "//div[@ng-model='admin.password']/div/div/input").click
	@driver_new.find_element(:xpath, "//div[@ng-model='admin.password']/div/div/input").send_keys @config['security']['new_pass']
	sleep(2)
	@driver_new.find_element(:xpath, "//div[@ng-model='admin.password_confirmation']/div/div/input").click
	@driver_new.find_element(:xpath, "//div[@ng-model='admin.password_confirmation']/div/div/input").send_keys @config['security']['new_pass']
	sleep(2)
	@driver_new.find_element(:xpath, "//button[@ng-click='save()']").click
	sleep(2)
	puts "Admin changed the password in Window 1"
	puts "Switch window"
	#switch to the previous window
	@driver.get(@base_url + "/dashboard")
	sleep(2)
	if(@driver.find_element(:css, "input.btn.btn-login.test-login-button").displayed?)
	puts "The login button is displayed which implies that the admin in window 1 was forced to log out."
	sleep(2)
	else 
	puts "The login button is not displayed which implies that the admin in window 1 was not forced to log out."
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
