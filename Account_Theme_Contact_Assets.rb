require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "AccountThemeContactAssets" do

  before(:each) do
	@config = YAML.load_file("config_smiley.yml")
    @driver = Selenium::WebDriver.for :firefox
    @base_url = @config['admin']['base_url']
	@base_member_url = @config['member']['base_url']
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_account_theme_contact_assets" do
	#Login
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
	sleep(2)
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
	sleep(2)
    @driver.find_element(:name, "commit").click
	sleep(2)
	
	@driver.manage.window.maximize
	sleep(2)
	
	#Click Administration
    @driver.find_element(:link, "Administration").click
	
	#Click Account
    @driver.find_element(:link, "Account").click
    @driver.find_element(:xpath, "//button[@class='btn btn-default pull-right'][@ng-hide='edit_state']").click
	sleep(2)
	#Upload an account logo
	@driver.execute_script('$(\'input.js-logo-field[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.js-logo-field[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	#Save
    @driver.find_element(:css, "a.btn.btn-default").click
	sleep(2)
	
	#Click Theme
    @driver.find_element(:link, "Theme").click
	#delete default Theme
    @driver.find_element(:css, "button.btn-trash-photo").click
	#Upload Theme 
	@driver.execute_script('$(\'input.background-field[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.background-field[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
	#Upload Account Logo
	@driver.execute_script('$(\'input.logo-field[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.logo-field[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
	#Upload Account Favicon
	@driver.execute_script('$(\'input.favicon-field[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.favicon-field[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
    #Save
	#@driver.find_element(:xpath, "//button[@class='btn.btn-default.pull-right'][@type='submit']").click
	@driver.find_element(:css, "button.btn.btn-default.pull-right").click
	
	#Click Contact information
    @driver.find_element(:link, "Contact Information").click
	@driver.find_element(:id, "account_contacts").clear
    @driver.find_element(:id, "account_contacts").send_keys "Contact information Contact information \nContact information"
	@driver.find_element(:name, "commit").click

	#Click Assets
	
	#Terms and conditions
    @driver.find_element(:link, "Assets").click
    @driver.find_element(:id, "policy_name").clear
    @driver.find_element(:id, "policy_name").send_keys "Terms and condition name"
    @driver.find_element(:id, "policy_text").clear
    @driver.find_element(:id, "policy_text").send_keys "Terms and condition  Text Terms and condition  Text Terms and condition  Text Terms and condition  TextTerms and condition  Text\n\nTerms and condition  TextTerms and condition  TextTerms and condition  TextTerms and condition  TextTerms and condition  TextTerms and condition  Text"
    @driver.find_element(:name, "commit").click
	
	#Scroll
	@driver.execute_script("scroll(0, 250);")
	sleep(2)
	
	#Privacy
    @driver.find_element(:css, "input.policy_name.form-control").clear
    @driver.find_element(:css, "input.policy_name.form-control").send_keys "Privacy Name"
    @driver.find_element(:css, "input.policy_text.form-control").click
    @driver.find_element(:css, "input.policy_text.form-control").clear
    @driver.find_element(:css, "input.policy_text.form-control").send_keys "Privacy Text Privacy TextPrivacy TextPrivacy TextPrivacy TextPrivacy TextPrivacy Text\n\nPrivacy TextPrivacy TextPrivacy Text"
    @driver.find_element(:css, "input.btn.btn-default[@value='Update Privacy']").click
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Disclosure
    @driver.find_element(:css, "#edit_policy_1732 > div.row > div.col-md-8 > div.form-group > #policy_name").clear
    @driver.find_element(:css, "#edit_policy_1732 > div.row > div.col-md-8 > div.form-group > #policy_name").send_keys "Disclosure Name"
    @driver.find_element(:css, "#edit_policy_1732 > div.row > div.col-md-8 > div.form-group > #policy_text").clear
    @driver.find_element(:css, "#edit_policy_1732 > div.row > div.col-md-8 > div.form-group > #policy_text").send_keys "Disclosure Text Disclosure TextDisclosure TextDisclosure TextDisclosure Text\nDisclosure TextDisclosure TextDisclosure TextDisclosure Text"
    @driver.find_element(:css, "#edit_policy_1732 > input[name=\"commit\"]").click
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#About us
    @driver.find_element(:css, "#edit_policy_1733 > div.row > div.col-md-8 > div.form-group > #policy_name").clear
    @driver.find_element(:css, "#edit_policy_1733 > div.row > div.col-md-8 > div.form-group > #policy_name").send_keys "About Us name"
    @driver.find_element(:css, "#edit_policy_1733 > div.row > div.col-md-8 > div.form-group > #policy_text").clear
    @driver.find_element(:css, "#edit_policy_1733 > div.row > div.col-md-8 > div.form-group > #policy_text").send_keys "About Us Text About Us TextAbout Us TextAbout Us TextAbout Us Text\n\nAbout Us TextAbout Us TextAbout Us Text"
    @driver.find_element(:css, "#edit_policy_1733 > input[name=\"commit\"]").click
	
	
    @driver.find_element(:link, "Home Page").click
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
