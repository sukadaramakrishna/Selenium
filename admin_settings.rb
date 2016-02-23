require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"

include RSpec::Expectations

describe "AdminSettings" do

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
  
  it "test_admin_settings" do
    @driver.get(@base_url + "/admins/sign_in")
	sleep(1)
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
	sleep(1)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
    @driver.find_element(:name, "commit").click
	sleep(2)
	@driver.manage.window.maximize
	sleep(1)
    @driver.find_element(:link, "Administration").click
	sleep(1)
    @driver.find_element(:xpath, "(//button[@type='button'])[1]").click
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[0]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[0]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[3]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[3]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[5]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[5]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[6]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[6]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[11]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[11]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[12]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[12]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[13]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[13]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[17]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[17]").send_keys "10"
    @driver.find_element(:xpath, "(//input[@type='number'])[19]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[19]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").click
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").click
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[22]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[22]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").click
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[28]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[28]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[29]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[29]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").click
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[34]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[34]").send_keys "5"
    @driver.find_element(:xpath, "(//input[@type='number'])[35]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[35]").send_keys "100"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[15]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div/div/input").send_keys "Member Flag1"
    @driver.find_element(:css, "div.member-flag-edit > button.btn.btn-draggable-add").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div[2]/div/input").send_keys "Member Flag 2"
    @driver.find_element(:css, "div.member-flag-edit > button.btn.btn-draggable-add").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[8]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[8]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[9]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[9]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[10]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[10]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[11]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[11]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[12]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[12]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[13]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").send_keys "Smiley Blog"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").send_keys "http://blog.smiley360.com/"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[14]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").send_keys "FAQ"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").send_keys "http://smiley360.helpscoutdocs.com/"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div[2]/input").send_keys "Smiley360"
    @driver.find_element(:xpath, "//input[@type='checkbox']").click
    @driver.find_element(:xpath, "//input[@type='checkbox']").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[2]/input").send_keys "Smiley360"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[2]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[2]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[3]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[3]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[3]/div[2]/div/div[2]/input").send_keys "Smiley360"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[4]").click
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[4]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[4]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[4]/div[2]/div/div[2]/input").send_keys "MySmiley360"
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[5]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").send_keys "Twitter Parties"
    @driver.find_element(:css, "button.btn.btn-draggable-add").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").send_keys "Special Promotions"
    @driver.find_element(:css, "button.btn.btn-draggable-add").click
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
