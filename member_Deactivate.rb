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
    sleep(1)
	@driver.find_element(:link, "History").click
	sleep(2)
	@driver.find_element(:xpath, "//c-deactivate-prompt").click
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='modal-content'])[6]/form/div[2]").click
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='modal-footer'])[2]/a").click
	sleep(1)
	@driver.find_element(:xpath, "(//div[@class='modal-footer'])[2]/a").click
	sleep(1)
	#Verify by siging in again
	@driver.get(@base_url + "/home")
	sleep(2)
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
	sleep(1)
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(1)
	@driver.save_screenshot "Screenshots/afterDeactivateMember.png"
	sleep(2)
	puts "Profile has been edited. Test passed."
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
