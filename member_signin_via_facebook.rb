require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "MemberSigninViaFacebook" do

  before(:each) do
	@config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @config['member']['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_member_signin_via_facebook" do
    @driver.get(@base_url + "/home")
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
	@driver.find_element(:xpath, "//a[@href='/members/auth/facebook']").click
    sleep(2)
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys @config['signup']['email_facebook']
	@driver.find_element(:id, "pass").clear
	sleep(2)
    @driver.find_element(:id, "pass").send_keys @config['signup']['pass_facebook']
    #@driver.find_element(:id, "email").clear
    #@driver.find_element(:id, "email").send_keys "tripthi.shetty@socialmedialink.co"
    #@driver.find_element(:id, "u_0_1").click
    @driver.find_element(:id, "loginbutton").click
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
