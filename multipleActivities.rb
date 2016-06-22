require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "MultipleActivities" do

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
  
  it "test_multiple_activities" do
  login()
  #creating_groups()
  creating_activities()
  mission_logic()
  
  end
  
    def login()  
    @driver.get(@base_url + "/admins/sign_in")
	sleep(2)
	#login
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
	end
	def creating_groups()
    @driver.find_element(:link, "Mission Hubs").click
	sleep(2)
    @driver.find_element(:link, "Groups and Lists").click
	sleep(2)
	#Create group for Males
    @driver.find_element(:link, "Create Group").click
	sleep(2)
    @driver.find_element(:css, "button.btn-edit").click
	sleep(2)
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").send_keys "Males"
	sleep(2)
	
    @driver.find_element(:css, "a.test-group-gender-link").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox.control-checkbox-primary[for='checkbox_criterias.gender_male']").click
	sleep(1)
    #@driver.find_element(:css, "span.ng-scope.ng-binding").click
    #@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div[3]/div/div/div/div/div/div[2]/div/div/div[2]/button").click
    @driver.find_element(:link, "Save").click
	sleep(2)
	
	#Create group for Females
    @driver.find_element(:link, "Create Group").click
	sleep(2)
    @driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div/div/div/div/div/input").send_keys "Females"
	sleep(2)
    @driver.find_element(:css, "a.test-group-gender-link").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox.control-checkbox-primary[for='checkbox_criterias.gender_female']").click
	sleep(1)
    #@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div/div[3]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/span/label/span/span").click
    @driver.find_element(:link, "Save").click
	sleep(2)
	end
	def creating_activities()
    @driver.find_element(:link, "Mission Hubs").click
	#Creating a mission hub
    @driver.find_element(:link, "New Mission Hub").click
    sleep(4)
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Multiple activities"
	sleep(2)
    @driver.find_element(:css, "button.btn.btn-default").click
	sleep(4)
	
	#Creating the first activity
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
    sleep(3)
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Activity for Males"
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	sleep(2)
    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity for Males"
	sleep(1)
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	#Toggle Face2face
    @driver.find_element(:id, "switch_cb_face2face").click
	sleep(2)
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	#Creating the second activity
    @driver.find_element(:link, "Multiple activities").click
	sleep(1)
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
    sleep(3)
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.q-field.ng-pristine[placeholder='Type a activity name']").send_keys "Activity for Females"
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	sleep(2)
    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Activity for Females"
	sleep(1)
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	#Toggle Face2face
    @driver.find_element(:id, "switch_cb_face2face").click
	sleep(2)
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(6)
	end
	def mission_logic()
	#Mission Logic section
    @driver.find_element(:link, "Multiple activities").click
    sleep(2)
    @driver.find_element(:link, "Mission Logic").click
	sleep(2)
	#define the two mission logic sections
	section = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-0.test-hub-logic-item-activity")
	section[0].find_element(:css, "a").click
	@driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '21') and @class='day']").click
	@driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2568']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
    @driver.find_element(:css, "span.control-checkbox-dark").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_0']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-save").click
	sleep(4)
	@driver.find_element(:css, "a.mlogic-close").click
	sleep(2)
	@driver.find_element(:link, "Mission Logic").click
	sleep(2)
	@driver.execute_script("scroll(0, 250);")
	sleep(1)
	#@driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	#@driver.find_element(:xpath,"(//div[@class='mlogic-title.ng-binding'])[1]")
	sleep(3)
	section1 = @driver.find_elements(:css,"li.mlogic-list-item.test-hub-logic-item-1.test-hub-logic-item-activity")
	section1[0].find_element(:css, "a").click
	#@driver.find_element(:css, "a.mlogic-link.test-hub-logic-item-view.ng-scope").click
	@driver.find_element(:css,"li.mlogic-list-item.test-hub-logic-item-1.test-hub-logic-item-activity")
	@driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '21') and @class='day']").click
	@driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__2569']").click
	sleep(1)
	@driver.find_element(:css, "button.test-hub-logic-item-group-save").click
	sleep(1)
    @driver.find_element(:css, "span.control-checkbox-dark").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='send_sample_1']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").click
	@driver.find_element(:css, "input.ng-pristine[ng-model='rule.distribution_limit']").send_keys "1"
	@driver.find_element(:css, "label.switcher.ng-scope").click
	sleep(1)
	
	
	@driver.find_element(:css, "button.test-hub-logic-save").click
	
	
	
	

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
