require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"

include RSpec::Expectations

describe "CreateSurvey" do

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
  
  it "test_create_survey" do
	create_survey()
	survey_missionlogic()
	sleep(60)
	check_survey()
	end
  
	def create_survey()
	
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
    @driver.find_element(:name, "commit").click
	@driver.manage.window.maximize
    @driver.find_element(:link, "Mission Hubs").click
    @driver.find_element(:link, "New Mission Hub").click
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Survey XYZ"
	sleep(1)
   	@driver.find_element(:css, "button.btn-default").click
	@driver.find_element(:css, "li.test-hub-new-survey").click
	sleep(3)
    @driver.find_element(:link, "New Survey").click
	sleep(7)
	@driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").send_keys "Survey XYZ"
	#Single Image
	@driver.find_element(:css, "span.icon-single_image").click
	
    @driver.find_element(:link, "Survey XYZ").click
	sleep(1)
	
	@driver.find_element(:css, "a.rowclick.test-hub-structure-item-link.ng-binding").click
	sleep(2)
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 400);")
	sleep(4)

	 @driver.find_element(:css, "strong.q-list-type-reward").click

	
	@driver.find_element(:css, "input.reward-points-field").clear
	@driver.find_element(:css, "input.reward-points-field").send_keys "10"
	sleep(2)
	@driver.find_element(:xpath, "(//button[@type='button'])[44]").click
	sleep(2)
   @driver.find_element(:css, "strong.q-list-type-badge").click
	sleep(2)
	puts "abc"
	@driver.execute_script('$(\'input.js-badge-image-field[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.js-badge-image-field[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpg")
	sleep(3)
	@driver.find_element(:css, "textarea.test-activity-badge-name").clear
	@driver.find_element(:css, "textarea.test-activity-badge-name").send_keys "Survey XYZ Badge name"
	@driver.find_element(:xpath, "(//button[@type='button'])[46]").click
	sleep(2)
	
	@driver.find_element(:link, "Survey XYZ").click
	sleep(1)
	end
	def survey_missionlogic
    @driver.find_element(:link, "Mission Logic").click
	sleep(1)
	@driver.find_element(:css, "div.mlogic-step.ng-scope").click
    @driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '26') and @class='day']").click
	#@driver.find_element(:xpath, "//td[@class='day active']").click
    @driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__1210']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_0']").click
	sleep(1)
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(140)
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
