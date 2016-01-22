require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "FacebookSMLSignup" do

  before(:each) do
	config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = config['member']['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
	@first_name = config['signup']['first_name']
	@last_name = config['signup']['last_name']
	@email = config['signup']['email_facebook']
	@pass = config['signup']['pass_facebook']
	@zip = config['signup']['zip']
  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_facebook_signup" do
    @driver.get(@base_url+'/home')

    @driver.find_element(:css, "a[href='/members/auth/facebook']").click
    sleep(2)
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys @email
    sleep(2)
    @driver.find_element(:id, "pass").clear
    @driver.find_element(:id, "pass").send_keys @pass
    sleep(1)
    @driver.find_element(:id, "u_0_2").click
	sleep(1)
	#@driver.find_element(:css, "button[name='__CONFIRM__']").click
	sleep(3)
	@driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @zip
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
