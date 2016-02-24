require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "To" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://admin-staging.socialmedialink.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_to" do
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys "tripthi.testmember11@socialmedialink.com"
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys "12345678"
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys "tripthi.testmember2@socialmedialink.com"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:link, "Administration").click
    @driver.find_element(:xpath, "(//button[@type='button'])[2]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[13]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").send_keys "link"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").send_keys "title"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[14]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").send_keys "iink"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").send_keys "itle"
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
