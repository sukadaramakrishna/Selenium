require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "ConnectToSocialmedia" do

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
  
  it "test_connect_to_socialmedia" do
    @driver.get(@base_url + "/home")
	sleep(2)
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
	sleep(1)
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(1)
	@driver.manage.window.maximize
	sleep(2)
	@driver.find_element(:css, "span.header-user-name").click
    #scroll
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	@driver.save_screenshot "Screenshots/beforeProfileEdit.png"
	sleep(2)
	#Upload profile picture
    #@driver.find_element(:css, "div.btn.btn-color.profile-upload-btn").click
	sleep(2)
	@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	#Fill member about
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_about']").click
	#@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_about']").clear
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_about']").send_keys "member about member about member about"
	#scroll
	@driver.execute_script("scroll(0, 500);")
	sleep(4)
	#Fill Pinterest username
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_pinterest_user']").click
	@driver.find_element(:xpath, "//div[@class='form-group']/label[@for='member_pinterest_user']").send_keys "alokande"
	sleep(2)
	#save general information
	@driver.find_element(:xpath, "(//div[@class='mobile-minimize-content'])[1]/form/input").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	#click to change Hispanic option
	@driver.find_element(:xpath, "(//div[@class='mobile-minimize-content'])[2]/form/div[@class='form-group'][1]/div[2]/button").click
	sleep(1)
	#click Yes  (Hispanic)
	@driver.find_element(:xpath, "(//div[@class='limited-changes-field'])[3]/div[2]/div/select/option[2]").click
	sleep(1)
	#click to change Race and Ethnicity
	@driver.find_element(:xpath, "(//div[@class='mobile-minimize-content'])[2]/form/div[@class='form-group'][2]/div[2]/div/button").click
	sleep(1)
	#select asian
	@driver.find_element(:xpath, "(//div[@class='limited-changes-field'])[4]/div[2]/p[2]").click
	sleep(1)
	#Marital status
	@driver.find_element(:xpath, "(//div[@class='form-group'])[17]/p[1]/label").click
	sleep(1)
	#Choose children
	@driver.find_element(:xpath, "(//div[@class='form-group'])[18]/p[1]/label").click
	sleep(1)
	#choose month of birth 
	@driver.find_element(:xpath, "(//div[@class='form-group'])[20]/div[2]/div/div[1]/select/option[2]").click
	sleep(2)
	#choose year of birth
	@driver.find_element(:xpath, "(//div[@class='form-group'])[20]/div[2]/div/div[2]/select/option[4]").click
	sleep(4)
	#scroll
	@driver.execute_script("scroll(0, 2300);")
	sleep(4)
	#Blog
	#@driver.find_element(:xpath, "(//div[@class='form-group'])[21]/p[2]/label").click
	sleep(2)
	#click household income dropbox
	#@driver.find_element(:xpath, "//select[@id='member_household_income']").click
	sleep(2)
	#select household income
	@driver.find_element(:xpath, "//select[@id='member_household_income']/option[4]").click
	sleep(2)
	#save personal information
	@driver.find_element(:xpath, "(//div[@class='mobile-minimize-content'])[2]/form/input").click
	sleep(2)
	@driver.save_screenshot "Screenshots/afterProfileEdit.png"
	sleep(2)
	puts "Profile has been edited. Test passed."
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
