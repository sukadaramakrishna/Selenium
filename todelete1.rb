require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Todelete1" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://tripsprint57-staging.socialmedialink.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_todelete1" do
    @driver.get(@base_url + "/home")
    @driver.find_element(:css, "button.login-switch-button").click
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_email'])[2]").send_keys "mary.crawley@yopmail.com"
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").clear
    @driver.find_element(:xpath, "(//input[@id='member_password'])[2]").send_keys "12345678"
    @driver.find_element(:id, "confirm_age").click
    @driver.find_element(:css, "span").click
    @driver.find_element(:xpath, "(//input[@name='commit'])[2]").click
    @driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys "mry.crawley"
    @driver.find_element(:css, "input.sbut").click
    @driver.find_element(:id, "login").click
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys "mary.crawley"
    @driver.find_element(:css, "span.slientext").click
    # ERROR: Caught exception [ERROR: Unsupported command [selectFrame | ifmail | ]]
    @driver.find_element(:link, "CONFIRM ACCOUNT").click
    # ERROR: Caught exception [ERROR: Unsupported command [selectWindow | null | ]]
    @driver.find_element(:id, "member_first_name").clear
    @driver.find_element(:id, "member_first_name").send_keys "mary"
    @driver.find_element(:id, "member_last_name").clear
    @driver.find_element(:id, "member_last_name").send_keys "Crawley"
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys "92092"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_month")).select_by(:text, "September")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_day")).select_by(:text, "12")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_year")).select_by(:text, "2004")
    @driver.find_element(:id, "member_gender_male").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_year")).select_by(:text, "1999")
    @driver.find_element(:name, "commit").click
    @driver.find_element(:link, "Go To Dashboard").click
  end
  
  def element_present?(how, what)
    ${receiver}.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    ${receiver}.switch_to.alert
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
    alert = ${receiver}.switch_to().alert()
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
