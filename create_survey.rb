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
    @driver.find_element(:link, "Mission Hubs").click
    @driver.find_element(:link, "New Mission Hub").click
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Survey ABC"
	sleep(1)
   	@driver.find_element(:css, "button.btn-default").click
	@driver.find_element(:css, "li.test-hub-new-survey").click
	sleep(3)
    @driver.find_element(:link, "New Survey").click
	sleep(7)
	@driver.find_element(:css, "button.btn-edit").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div/div/div[2]/div/input").send_keys "Survey ABC"
    @driver.find_element(:css, "span.icon-single_answer").click
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").clear
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").send_keys "Question 1"
	sleep(1)
	@driver.find_element(:css, "button.q-list-add").click
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-0").clear
	@driver.find_element(:css, "textarea.test-question-answer-0").send_keys "Answer 1"
	sleep(1)
	@driver.action.send_keys(:enter).perform
	@driver.find_element(:css, "textarea.test-question-answer-1").clear
	@driver.find_element(:css, "textarea.test-question-answer-1").send_keys "Answer 2"
	sleep(1)
	@driver.action.send_keys(:enter).perform
	@driver.find_element(:css, "textarea.test-question-answer-2").clear
	@driver.find_element(:css, "textarea.test-question-answer-2").send_keys "Answer 3"
	sleep(1)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	@driver.find_element(:css, "li.test-question-new-multiple_answers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Question 2"
	sleep(2)
	
	@driver.find_element(:css, "textarea.test-question-answer-0").clear
	@driver.find_element(:css, "textarea.test-question-answer-0").send_keys "Answer 1"
	@driver.action.send_keys(:enter).perform
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-1").clear
	@driver.find_element(:css, "textarea.test-question-answer-1").send_keys "Answer 2"
	@driver.action.send_keys(:enter).perform
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-2").clear
	@driver.find_element(:css, "textarea.test-question-answer-2").send_keys "Answer 3"
	sleep(1)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(1)
    @driver.find_element(:link, "Survey ABC").click
	sleep(1)
	end
	def survey_missionlogic
    @driver.find_element(:link, "Mission Logic").click
	sleep(1)
	@driver.find_element(:css, "div.mlogic-step.ng-scope").click
    @driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '17') and @class='day']").click
	#@driver.find_element(:xpath, "//td[@class='day active']").click
    @driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__498']").click
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
  
  def check_survey() 
  #check if survey exists on user side
    @driver.get(@config['member']['base_url']	+ "/home")
    @driver.find_element(:link, "or your email address").click
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(3)
	@driver.save_screenshot "Screenshots/survey.png"
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
