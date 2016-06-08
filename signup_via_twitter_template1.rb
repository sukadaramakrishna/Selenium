require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "TwitterSmlSignup" do

  before(:each) do
	config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = config['member']['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
	@first_name = config['signup']['first_name']
	@last_name = config['signup']['last_name']
	@email = config['signup']['email_twitter']
	@pass = config['signup']['pass_twitter']
	@zip = config['signup']['zip']
	end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_twitter_signup" do
    @driver.get(@base_url + "/home")
    #@driver.find_element(:css, "a[href='/members/auth/twitter']").click
	@driver.find_element(:css, "a.login-connect-twitter").click
	sleep(1)
	
    @driver.find_element(:id, "username_or_email").clear
    @driver.find_element(:id, "username_or_email").send_keys @email
	sleep(1)
	@driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys @pass
	sleep(1)
    @driver.find_element(:id, "allow").click
	sleep(4)
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @email
    @driver.find_element(:id, "member_last_name").clear
    @driver.find_element(:id, "member_last_name").send_keys @last_name
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @zip
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_month")).select_by(:text, "September")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_day")).select_by(:text, "15")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_year")).select_by(:text, "1987")
    @driver.find_element(:css, "label.control-radio").click
    @driver.find_element(:name, "commit").click
	sleep(2)
	@driver.find_element(:css, "a.btn.btn-color.btn-lg").click
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
