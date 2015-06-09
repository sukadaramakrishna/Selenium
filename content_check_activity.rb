require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "ContentCheckActivity" do

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
  
  it "test_content_check_activity" do
	activity_content_create()
	activity_content_check()
	end
  
  
  def activity_content_create()
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
    @driver.find_element(:name, "commit").click
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
    @driver.find_element(:link, "Mission Hubs").click
	sleep(1)
    @driver.find_element(:link, "New Mission Hub").click
    @driver.find_element(:css, "input.ng-pristine").clear
    @driver.find_element(:css, "input.ng-pristine").send_keys "Activity Content Check"
	sleep(1)
	@driver.find_element(:css, "button.btn-default").click
	sleep(2)
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(2)
    @driver.find_element(:link, "New Activity").click
	sleep(2)
    @driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").send_keys "Activity Content Check"
	sleep(1)
    #@driver.find_element(:xpath, "//textarea[@type='text']").click
    @driver.find_element(:xpath, "//textarea[@type='text']").clear
    @driver.find_element(:xpath, "//textarea[@type='text']").send_keys "Activity Content Check"
	sleep(1)
    @driver.find_element(:css, "textarea.test-activity-tagline").clear
    @driver.find_element(:css, "textarea.test-activity-tagline").send_keys "Mission offer"
	sleep(1)
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Mission Details']").click
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Mission Details']").clear
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Mission Details']").send_keys "Mission details"
    sleep(1)
    @driver.find_element(:id, "switch_cb_activity.page.show_details").click
    sleep(2)
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").click
    @driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").clear
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").send_keys "Description of the product(offer)"
	sleep(2)
	
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	sleep(1)
	@driver.find_element(:css, "button.test-activity-save").click
	sleep(4)
    @driver.find_element(:link, "Offer Page").click
	sleep(3)
    @driver.find_element(:id, "switch_cb_copyContentFromOverview").click
	sleep(1)
    @driver.find_element(:css, "textarea.mission-page-title").clear
    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity Content Check (offer)"
    sleep(1)
    @driver.find_element(:css, "textarea.test-activity-tagline").clear
    @driver.find_element(:css, "textarea.test-activity-tagline").send_keys "Mission offer (offer)"
	sleep(1)
	
	@driver.find_element(:css, 'div.row').click
	@driver.find_element(:css, "div.angular-medium-editor").clear
	@driver.find_element(:css, "div.angular-medium-editor").send_keys "Mission details (offer)"
	sleep(2)
    @driver.find_element(:css, "button.test-activity-save").click
	sleep(3)
	@driver.find_element(:link, "Mission Page").click
	sleep(3)
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").click
    @driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").clear
	@driver.find_element(:css, "div.angular-medium-editor[data-placeholder='Description of product']").send_keys "Description of the product"
	sleep(2)
	@driver.find_element(:css, "button.test-activity-save").click
	sleep(3)
	
   
    @driver.find_element(:link, "Activity Content Check").click
	sleep(4)
	
    @driver.find_element(:link, "Mission Logic").click
   
    @driver.find_element(:css, "div.mlogic-step.ng-scope").click
	@driver.find_element(:id, "date-start").click
	#@driver.find_element(:xpath, "//div[@id='sizzle-1424799674381']/div/table/tbody/tr[5]/td[3]").click
	@driver.find_element(:xpath, "//td[contains(text(), '5') and @class='day']").click
	@driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__586']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(180)
	end
	
	def activity_content_check()
	@driver.get(@config['member']['base_url']	+ "/home")
    @driver.find_element(:link, "or your email address").click
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(5)
	@driver.save_screenshot "Screenshots/dashboard.png"
	@driver.find_element(:link, "Activity Content Check (offer)").click
	sleep(2)
	@driver.save_screenshot "Screenshots/offerpage.png"
	
    @driver.find_element(:css, "span.btn-color").click
    @driver.save_screenshot "Screenshots/activitypage.png"
	
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
