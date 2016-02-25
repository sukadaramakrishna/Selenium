require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "ConnectToSocialmedia" do

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
  
  it "test_connect_to_socialmedia" do
    @driver.get(@base_url + "/home")
	sleep(2)
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
	sleep(1)
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(1)
	@driver.manage.window.maximize
	sleep(2)
	@driver.find_element(:css, "span.header-user-name").click
    #scroll
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	#connect facebook
    @driver.find_element(:link, "Connect").click
	sleep(1)
	@driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys @config['signup']['email_facebook']
    sleep(2)
    @driver.find_element(:id, "pass").clear
    @driver.find_element(:id, "pass").send_keys @config['signup']['pass_facebook']
    sleep(1)
    @driver.find_element(:id, "loginbutton").click

	#connect twitter
    @driver.find_element(:link, "Connect").click
	sleep(1)
    @driver.find_element(:id, "username_or_email").clear
    @driver.find_element(:id, "username_or_email").send_keys @config['signup']['email_twitter']
	sleep(1)
	@driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys @config['signup']['pass_twitter']
	sleep(1)
    @driver.find_element(:id, "allow").click
	
	#connect instagram
    @driver.find_element(:link, "Connect").click
	sleep(1)
    @driver.find_element(:id, "id_username").clear
    @driver.find_element(:id, "id_username").send_keys @config['signup']['email_instagram']
	sleep(1)
    @driver.find_element(:id, "id_password").clear
    @driver.find_element(:id, "id_password").send_keys @config['signup']['pass_instagram']
	sleep(1)
    @driver.find_element(:css, "input.button-green").click
	sleep(2)
	@driver.save_screenshot "Screenshots/connect_to_socialmedia.png"
	
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
