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
	#Single Answer Question
    @driver.find_element(:css, "span.icon-single_answer").click
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").clear
	@driver.find_element(:css, "textarea.test-survey-item-field[placeholder='Type a question']").send_keys "Single Answer Question "
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
	#Multiple Answer Question
	@driver.find_element(:css, "li.test-question-new-multiple_answers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Multiple Answer Question "
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
	#Text Question
	@driver.find_element(:css, "li.test-question-new.test-question-new-text").click
	sleep(3)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Text Question "
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(1)
	#Numbers Question
	@driver.find_element(:css, "li.test-question-new.test-question-new-numbers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Numbers Question "
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(2)
	#Yes or No
	@driver.find_element(:css, "li.test-question-new.test-question-new-yes_or_no").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Yes or No Question "
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	#Ranking
	@driver.find_element(:css, "li.test-question-new.test-question-new-ranking").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Ranking Question "
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-answer-0").clear
	@driver.find_element(:css, "textarea.test-question-answer-0").send_keys "Ranking 3"
	@driver.action.send_keys(:enter).perform
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-1").clear
	@driver.find_element(:css, "textarea.test-question-answer-1").send_keys "Ranking 2"
	@driver.action.send_keys(:enter).perform
	sleep(1)
	@driver.find_element(:css, "textarea.test-question-answer-2").clear
	@driver.find_element(:css, "textarea.test-question-answer-2").send_keys "Ranking 1"
	sleep(1)	
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	#Matrix Single
	@driver.find_element(:css, "li.test-question-new.test-question-new-matrix_with_single_answer").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Single Matrix Question "
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").send_keys "row 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").send_keys "row 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").send_keys "row 3"
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").send_keys "col 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").send_keys "col 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").send_keys "col 3"
	sleep(2)
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	#Matrix Multiple
	@driver.find_element(:css, "li.test-question-new.test-question-new-matrix_with_multiple_answers").click
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-name").clear
	@driver.find_element(:css, "textarea.test-question-name").send_keys "Multiple Matrix Question "
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-0").send_keys "row 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-1").send_keys "row 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-row-2").send_keys "row 3"
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-0").send_keys "col 1"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-1").send_keys "col 2"
	@driver.action.send_keys(:enter).perform
	sleep(2)
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").clear
	@driver.find_element(:css, "textarea.test-question-matrix-col-2").send_keys "col 3"
	sleep(2)
	
	@driver.find_element(:css, "button.test-question-create").click
	sleep(3)
	
    @driver.find_element(:link, "Survey ABC").click
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
	@driver.find_element(:css, "textarea.test-activity-badge-name").send_keys "Survey ABC Badge name"
	@driver.find_element(:xpath, "(//button[@type='button'])[46]").click
	sleep(2)
	
	@driver.find_element(:link, "Survey ABC").click
	sleep(1)
	end
	def survey_missionlogic
    @driver.find_element(:link, "Mission Logic").click
	sleep(1)
	@driver.find_element(:css, "div.mlogic-step.ng-scope").click
    @driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '19') and @class='day']").click
	#@driver.find_element(:xpath, "//td[@class='day active']").click
    @driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__596']").click
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
	
	@driver.find_element(:link, "Survey ABC").click
	sleep(2)
	@driver.find_element(:xpath, "//*[contains(text(), 'Accept')]").click
	sleep(2)
	@driver.find_element(:css, "a.btn.btn-color").click
	sleep(2)
	#Single Answer select
	@driver.find_element(:css, "label.control-radio.ng-binding[for='radio_text_6525_1']").click
	sleep(2)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Multiple Answer select
	@driver.find_element(:css, "label.control-checkbox.ng-binding[for='checkbox_text_6526_0']").click
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox.ng-binding[for='checkbox_text_6526_2']").click
	sleep(2)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Text Answer
	@driver.find_element(:css, "textarea.q-field.ng-pristine.ng-valid").click
	@driver.find_element(:css, "textarea.q-field.ng-pristine.ng-valid").send_keys "abc"
	sleep(2)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Numbers Answer
	@driver.find_element(:css, "input.form-control-number[placeholder='Answer with digits']").click
	@driver.find_element(:css, "input.form-control-number[placeholder='Answer with digits']").send_keys "123"
	sleep(2)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Yes or No Answer
	@driver.find_element(:css, "label.control-radio.ng-binding[for='radio_text_6529_0']").click
	sleep(2)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Ranking Answer
	#int source = span.control-sortable.js-handle.ng-binding[0].element
	#int target = span.control-sortable.js-handle.ng-binding[1].element
	#@browser.action.drag_and_drop(source, target).perform
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Single Matrix Answer
	@driver.find_element(:css, "label.control-radio[for='radio_matrix_6531_27979_0']").click
	sleep(1)
	@driver.find_element(:css, "label.control-radio[for='radio_matrix_6531_27980_1']").click
	sleep(1)
	@driver.find_element(:css, "label.control-radio[for='radio_matrix_6531_27981_2']").click
	sleep(1)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
	#Multiple Matrix Answers
	@driver.find_element(:css, "label.control-checkbox[for='checkbox_matrix_6532_27985_0']").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox[for='checkbox_matrix_6532_27986_0']").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox[for='checkbox_matrix_6532_27987_1']").click
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox[for='checkbox_matrix_6532_27986_2']").click
	sleep(1)
	@driver.find_element(:css, "button.btn.button").click
	sleep(2)
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
