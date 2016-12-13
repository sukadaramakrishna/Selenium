require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "EmailSignup" do

  before(:each) do
	puts 'selenium test running before'
	config = YAML.load_file("config_smiley.yml")
	
    @driver = Selenium::WebDriver.for :firefox
	@base_url = config['member']['base_url']
    @resend_base_url = config['member']['resend_confirm_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
	@name = config['member']['resend_confirm']
	@pass = config['member']['pass']
	@zip = config['signup']['zip_CA']
  end
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_signup" do
    puts 'selenium test running'
	#signup
	@driver.get(@base_url + "/home")
    @driver.find_element(:css, "button.login-switch-button").click
	sleep(2)
	@driver.find_element(:xpath, "(//input[@id='member_email'])[2]").click
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").send_keys @name
	sleep(2)
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").send_keys @pass
    sleep(2)
    @driver.find_element(:css, "span").click
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
	sleep(2)
	#resend confirmation
    @driver.get(@resend_base_url)
	sleep(3)
	@driver.find_element(:xpath, "//div[@class='col-sm-9']/input").send_keys @name
	sleep(1)
	@driver.find_element(:css, "input.btn.btn-color.btn-lg").click
	sleep(1)
	puts "The test was successfull"
	sleep(2)
	#Verify if you got two emails in Yopmail
	@driver.get("http://yopmail.com");
	sleep(4)
	@driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys @name
    @driver.find_element(:css, "input.sbut").click
	sleep(1)
	@driver.save_screenshot "Screenshots/resendConfirmationEmails.png"
	puts "Screen shot of yopmail taken"
	sleep(1)
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
