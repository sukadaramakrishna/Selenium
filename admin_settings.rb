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
    @driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	sleep(1)

    @driver.find_element(:xpath, "(//input[@type='number'])[1]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[1]").send_keys "10"
	sleep(1)
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[2]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[2]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[3]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[3]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[4]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[4]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[5]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[5]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[6]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[6]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[7]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[7]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[8]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[8]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[9]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[9]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[10]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[10]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[11]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[11]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[12]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[12]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[13]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[13]").send_keys "10"
	sleep(1)
	 @driver.find_element(:xpath, "(//input[@type='number'])[14]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[14]").send_keys "10"
	sleep(1)
	 @driver.find_element(:xpath, "(//input[@type='number'])[15]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[15]").send_keys "10"
	sleep(1)
	 @driver.find_element(:xpath, "(//input[@type='number'])[16]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[16]").send_keys "10"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[17]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[17]").send_keys "10"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[18]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[18]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[19]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[19]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[20]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[21]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[22]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[22]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[23]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[24]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[24]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[25]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[25]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[26]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[26]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[27]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[27]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[28]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[28]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[29]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[29]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[30]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[31]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[31]").send_keys "5"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='number'])[32]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[32]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[33]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[33]").send_keys "5"
	sleep(1)
    @driver.find_element(:xpath, "(//input[@type='number'])[34]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[34]").send_keys "5"
	sleep(1)

    @driver.find_element(:xpath, "(//input[@type='number'])[35]").clear
    @driver.find_element(:xpath, "(//input[@type='number'])[35]").send_keys "100"
	sleep(2)

	#Social Media Pages
	#@driver.find_element(:xpath, "(//input[@type='checkbox'])[0]").click
	@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div/div[2]/div/div[2]/input").send_keys "Smiley360"
	sleep(1)
	#@driver.find_element(:xpath, "(//input[@type='checkbox'])[1]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[2]/div[2]/div/div[2]/input").send_keys "Smiley360"
	sleep(1)
    #@driver.find_element(:xpath, "(//input[@type='checkbox'])[2]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[3]/div[2]/div/div[2]/input").send_keys "Smiley360"
	sleep(1)
    #@driver.find_element(:xpath, "(//input[@type='checkbox'])[3]").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[4]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div/div[2]/div/div[4]/div[2]/div/div[2]/input").send_keys "MySmiley360"
	sleep(1)
	
	#Features section
    #Brand connect Toggle
    @driver.find_element(:xpath, "(//input[@type='checkbox'])[5]").click
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.custom_brand_connect_name.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.custom_brand_connect_name.value']").send_keys "Brand Connect"
	sleep(1)
	#Tutorial Toggle
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[6]").click
	#Welcome Email Toggle
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[7]").click
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.welcome_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.welcome_email.value']").send_keys "welcome"
	sleep(1)
	#Mission Acceptance Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[8]").click
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_acceptance_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_acceptance_email.value']").send_keys "mission-acceptance"
	sleep(1)
	#Mission Completion Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[9]").click
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_completion_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.mission_completion_email.value']").send_keys "mission-complete-dev"
	sleep(1)
	#Post Acceptance Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[10]").click
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_accepted_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_accepted_email.value']").send_keys "activity-accepted"
	sleep(1)
	#Post Decline Email
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[11]").click
	@driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_declined_email.value']").clear
    @driver.find_element(:css, "input.form-control.ng-pristine.ng-valid[ng-model='config.feature.values.post_declined_email.value']").send_keys "activity-declined"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[12]").click
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 1300);")
	sleep(4)

	#Blog
	
	@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[2]/div[2]/div/div[2]/input").send_keys "http://blog.smiley360.com/"
	sleep(1)
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[3]/div/div[3]/div[2]/div/div[2]/input").send_keys "Blog"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[13]").click
	#FAQ
	
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[2]/div[2]/div/div[2]/input").send_keys "http://smiley360.helpscoutdocs.com/"
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[2]/div[4]/div/div[3]/div[2]/div/div[2]/input").send_keys "FAQ"
	sleep(1)
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[14]").click
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 0);")
	sleep(4)
	
	#Email Preferences
	@driver.find_element(:xpath, "(//input[@type='checkbox'])[15]").click
	sleep(1)
	@driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").send_keys "Twitter Parties"
    @driver.find_element(:css, "button.btn.btn-draggable-add").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[3]/div/div/div[2]/div[3]/div/input").send_keys "Special Promotions"
    @driver.find_element(:css, "button.btn.btn-draggable-add").click
	
	#Member Flags
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div/div/input").send_keys "Member Flag1"
	sleep(2)
    @driver.find_element(:css, "div.member-flag-edit > button.btn.btn-draggable-add").click
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div[2]/div/input").clear
    @driver.find_element(:xpath, "//body[@id='admin']/div/div[2]/div/div[2]/div/div[3]/div[4]/div/div[2]/div[2]/div/input").send_keys "Member Flag 2"
	sleep(2)
	@driver.find_element(:css, "div.member-flag-edit > button.btn.btn-draggable-add").click
	sleep(1)
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 0);")
	sleep(4)
	
	#Save
	@driver.find_element(:css, "a.btn.btn-default[ng-click='save()']").click
	sleep(1)
 
    
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
