require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "SharingtoolsShareLink" do

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
  
  it "test_sharingtools_share_link" do
  @driver.get(@base_url + "/home")
    @driver.find_element(:link, "or your email address").click
	sleep(1)
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
	sleep(1)
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(1)
	@driver.manage.window.maximize
	sleep(2)
    @driver.find_element(:link, "Sharing Tools Activity").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
    @driver.find_element(:name, "global-zeroclipboard-flash-bridge").click
    # ERROR: Caught exception [ERROR: Unsupported command [selectWindow | name=_e_0B9t | ]]
	driver = Selenium::WebDriver.for :firefox
	driver.get('https://www.facebook.com')

	body = driver.find_element(:tag_name => 'body')
	body.send_keys(:control, 't')

	driver.quit
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys "tripthi.shetty@socialmedialink.com"
    @driver.find_element(:id, "pass").clear
    @driver.find_element(:id, "pass").send_keys "general1234"
    @driver.find_element(:id, "u_0_n").click
    @driver.find_element(:css, "span._2dpb").click
    @driver.find_element(:id, "u_ps_jsonp_2_0_a").click
    @driver.find_element(:id, "u_ps_jsonp_2_0_r").click
    @driver.find_element(:id, "u_ps_jsonp_2_0_a").click
    @driver.find_element(:xpath, "(//button[@value='1'])[16]").click
    # ERROR: Caught exception [ERROR: Unsupported command [selectWindow | null | ]]
    @driver.find_element(:link, "Dashboard").click
    @driver.find_element(:link, "Sharing Tools Activity").click
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
