require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Todelete" do

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
  
  it "test_todelete" do
    @driver.get(@base_url + "/mission_hubs/2926/mission_logic#/")
    @driver.find_element(:css, "span.mlogic-text.ng-binding").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[6]").click
    @driver.find_element(:css, "span.control-checkbox.control-checkbox-dark").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/main/ul/li/div/div[8]/div[2]/div[2]/strong[3]/div/button").click
    @driver.find_element(:link, "Premission Survey").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/main/ul/li[2]/a/div[3]").click
    @driver.find_element(:id, "date-start").click
    @driver.find_element(:xpath, "//div[@id='sizzle-1468443248618']/div/table/tbody/tr[3]/td[4]").click
    @driver.find_element(:id, "date-end").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[7]").click
    @driver.find_element(:css, "span.control-checkbox.control-checkbox-dark").click
    @driver.find_element(:xpath, "//input[@type='checkbox']").click
    @driver.find_element(:css, "label.switcher.ng-scope > span").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/main/ul/li[2]/div/div[8]/div[2]/div[2]/strong[3]/div/button").click
    @driver.find_element(:link, "Activity PPA").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/main/ul/li[3]/a/div[3]").click
    @driver.find_element(:xpath, "//input[@type='checkbox']").click
    @driver.find_element(:css, "label.switcher.ng-scope").click
    @driver.find_element(:id, "date-start").click
    @driver.find_element(:xpath, "//div[@id='sizzle-1468443248618']/div/table/tbody/tr[3]/td[4]").click
    @driver.find_element(:id, "send_sample_2").click
    @driver.find_element(:css, "label.control-checkbox.control-checkbox-primary").click
    @driver.find_element(:xpath, "//input[@type='number']").clear
    @driver.find_element(:xpath, "//input[@type='number']").send_keys "1"
    @driver.find_element(:css, "button.mlogic-add-group").click
    @driver.find_element(:id, "checkbox__2618").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/main/ul/li[3]/div/div[7]/div/span/label").click
    @driver.find_element(:id, "checkbox__2618").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/main/ul/li[3]/div/div[7]/div/span/label").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[7]").click
    @driver.find_element(:css, "span.control-checkbox.control-checkbox-dark").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[8]").click
    @driver.find_element(:css, "c-mission-logic-adverse-event-activator.ng-isolate-scope > label > span.control-checkbox.control-checkbox-dark").click
    @driver.find_element(:id, "cep-number").clear
    @driver.find_element(:id, "cep-number").send_keys "434343"
    @driver.find_element(:id, "cep-name").clear
    @driver.find_element(:id, "cep-name").send_keys "cep name"
    @driver.find_element(:id, "product-name").clear
    @driver.find_element(:id, "product-name").send_keys "suspect product"
    @driver.find_element(:id, "submitter-name").clear
    @driver.find_element(:id, "submitter-name").send_keys "name of the submitter"
    @driver.find_element(:id, "vendor-email").clear
    @driver.find_element(:id, "vendor-email").send_keys "tripthi.shetty@socialmedialink.com"
    @driver.find_element(:id, "program-owner-name").clear
    @driver.find_element(:id, "program-owner-name").send_keys "pfizer owner"
    @driver.find_element(:xpath, "(//button[@type='button'])[2]").click
    @driver.find_element(:link, "Survey & Activity Pages").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/aside/div").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/aside").click
    @driver.find_element(:link, "Mission Logic").click
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
