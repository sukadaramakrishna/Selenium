require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "Shippingaddress" do

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
  
  it "test_shippingaddress" do
    @driver.get(@base_url + "/home")
	sleep(2)
    @driver.find_element(:link, "or your email address").click
	sleep(1)
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
	@driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
	sleep(1)
    @driver.find_element(:name, "commit").click
	sleep(1)
    @driver.find_element(:css, "span.header-user-name").click
	sleep(1)
    @driver.find_element(:link, "Shipping Address").click
	sleep(1)
    @driver.find_element(:id, "member_address_2").clear
    @driver.find_element(:id, "member_address_2").send_keys @config['signup']['address1']
	sleep(1)
    @driver.find_element(:id, "member_address_1").clear
    @driver.find_element(:id, "member_address_1").send_keys @config['signup']['address2']
	sleep(1)
	Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "member_state")).select_by(:text, @config['signup']['state'])
	sleep(1)
    @driver.find_element(:id, "member_city").clear
    @driver.find_element(:id, "member_city").send_keys @config['signup']['city']
	sleep(1)
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @config['signup']['zip']
	sleep(1)
	Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "member_country")).select_by(:text, "United States")
	sleep(1)
    @driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/shippingaddress.png"
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
