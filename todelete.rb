require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "Todelete" do

  before(:each) do
    config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://admin-smiley.socialmedialink.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
	@email = config['admin']['email']
	@pass = config['admin']['pass']
	@days = config['signup']['days']
  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_todelete" do
  @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @email
	sleep(1)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @pass
    @driver.find_element(:name, "commit").click
	@driver.manage.window.maximize
	sleep(2)
	@driver.find_element(:link, "Mission Hubs").click
	@driver.find_element(:link, "Mission date variable").click
	@driver.find_element(:link, "Mission Logic").click
	sleep(1)
    @driver.find_element(:css, "div.mlogic-step.ng-scope").click
    @driver.find_element(:id, "date-start").click
    #@driver.find_element(:xpath, "//div[@id='sizzle-1468957232864']/div/table/tbody/tr[4]/td[3]").click
	#@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	@driver.find_element(:xpath, "//td[contains(text(), '@days') and @class='day']").click
    @driver.find_element(:link, "Mission Hubs").click
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
