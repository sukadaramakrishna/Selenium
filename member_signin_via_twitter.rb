require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "MemberSigninViaTwitter" do

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
  
  it "test_member_signin_via_twitter" do
    @driver.get(@base_url + "/home")
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
    #@driver.find_element(:xpath, "//a[@href='/members/auth/twitter']").click
	@driver.find_element(:css, "a.login-connect-twitter").click
	sleep(2)
    #@driver.find_element(:link, "twitter").click
    @driver.find_element(:id, "username_or_email").clear
    @driver.find_element(:id, "username_or_email").send_keys @config['signup']['email_twitter']
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys @config['signup']['pass_twitter']
    @driver.find_element(:id, "allow").click
    #@driver.find_element(:id, "allow").click
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
