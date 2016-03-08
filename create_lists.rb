require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "CreateLists" do

  before(:each) do
  @config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @config['admin']['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_create_lists" do
   @driver.get(@config['admin']['base_url']	+ "/admins/sign_in")
    #@driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
	sleep(1)
    @driver.find_element(:name, "commit").click
	sleep(4)
	@driver.manage.window.maximize
	sleep(2)
    #@driver.get(@base_url + "/members_groups#/?mg_page=1")
    @driver.find_element(:link, "Groups and Lists").click
	sleep(2)
    @driver.find_element(:link, "Create List").click
	sleep(2)
	@driver.find_element(:css, "button.btn-edit").click
	sleep(2)
	@driver.find_element(:css, "input[placeholder='Type a members group name']").clear
	sleep(1)
	@driver.find_element(:css, "input[placeholder='Type a members group name']").send_keys "list creation test via selenium"
	sleep(2)
	@driver.find_element(:css, "span.btn.btn-default.fileinput-button").click
	sleep(1)
	@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input[type='file']").send_keys("C:\\Users\\Tripthi\\Documents\\test.csv")
	sleep(5)
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:css, "a.report-link").click
    @driver.find_element(:link, "Export to CSV").click
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
