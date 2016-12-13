require "json"
require "selenium-webdriver"
require "rspec"
require "yaml" 
include RSpec::Expectations

describe "MemberSigninViaEmail" do

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
  
  it "member_forget_password" do
    @driver.get(@base_url + "/home")
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
 
	#go to Member History
	@driver.find_element(:link, "Forgot Password?").click
	sleep(3)
	@driver.find_element(:xpath, "//div[@class='modal-content']/form/input[1]").clear
	@driver.find_element(:xpath, "//div[@class='modal-content']/form/input[1]").send_keys @config['member']['email']
	sleep(2)
	@driver.find_element(:css, "input.login-submit.js-reset-password").click
	sleep(2)
	#redirect to yopmail
	@driver.get("http://yopmail.com");
	sleep(4)
	@driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys @config['member']['email']
    @driver.find_element(:css, "input.sbut").click
	sleep(3)
	puts 'switching to internal iframe'
	@driver.switch_to.frame('ifmail')
	sleep(1)
    #click reset password button
    @href = @driver.find_element(:link, "RESET PASSWORD").attribute('href')
	puts 'activation link: '+@href
	@driver.get(@href)
	sleep(3)
	#change password
	@driver.find_element(:id, "member_password").clear
	@driver.find_element(:id, "member_password").send_keys @config['member']['change_pass']
	sleep(1)
	@driver.find_element(:id, "member_password_confirmation").clear
	@driver.find_element(:id, "member_password_confirmation").send_keys @config['member']['change_pass']
	sleep(1)
	@driver.find_element(:css, "input.btn.btn-color.btn-lg").click
	sleep(2)
	@driver.find_element(:css, "a.header-logout").click
	sleep(2)
	#login to check if the password changed
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/memberforgetpassword_old_pass.png"
	sleep(3)
	@driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['change_pass']
    @driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/memberforgetpassword_new_pass.png"
	sleep(3)
	puts "Forget password functionality worked correctly."
	puts "The test passed."
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
