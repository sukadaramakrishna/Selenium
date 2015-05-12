require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Todelete" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://admin-smiley.socialmedialink.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_todelete" do
    @driver.get(@base_url + "/surveys/557/questions#/")
    @driver.find_element(:css, "strong.q-list-type-reward").click
    @driver.find_element(:xpath, "//input[@type='text']").clear
    @driver.find_element(:xpath, "//input[@type='text']").send_keys "20"
    @driver.find_element(:xpath, "(//button[@type='button'])[44]").click
    @driver.find_element(:css, "li.q-list-item-section.ng-hide > div.q-list-item > div.q-list-link.q-list-reward").click
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/main/ul[5]/li[2]/div/div/div/div[2]/textarea").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/main/ul[5]/li[2]/div/div/div/div[2]/textarea").send_keys "nmnmnmnmnmnm"
    @driver.find_element(:xpath, "(//button[@type='button'])[46]").click
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
