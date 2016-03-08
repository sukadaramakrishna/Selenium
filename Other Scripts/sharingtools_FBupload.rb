require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"


include RSpec::Expectations

describe "Sharing Tools" do

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
  
  it "test_sharing_tools" do
    create_activity()
	mission_logic()
	sleep(180)
	login()
	#update_shippingaddress()
	#connect_facebook()
	fb_uploadphoto()
  end
  
  def create_activity()
    @driver.get(@base_url + "/admins/sign_in")
    @driver.find_element(:id, "admin_email").clear
    @driver.find_element(:id, "admin_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "admin_password").clear
    @driver.find_element(:id, "admin_password").send_keys @config['admin']['pass']
	sleep(1)
    @driver.find_element(:name, "commit").click
	sleep(4)
	@driver.manage.window.maximize
    @driver.get(@base_url + "/mission_hubs#?filter=current")
	sleep(1)
    @driver.find_element(:link, "Mission Hubs").click
	sleep(1)
    @driver.find_element(:link, "New Mission Hub").click
	sleep(1)
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").clear
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "FB Upload Activity"
	sleep(1)
	@driver.find_element(:css, "button.btn-default").click
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
	sleep(2)
	@driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").send_keys "FB Upload Activity"
	
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	
	sleep(2)

    @driver.find_element(:css, "textarea.mission-page-title").send_keys "FB Upload Activity"
	sleep(1)
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	
	
	#Toggle Upload Facebook
	@driver.find_element(:id, "switch_cb_upload_photo_facebook").click
	sleep(2)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_facebook.suggested_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_facebook.suggested_phrase']").send_keys "Upload photo to facebook suggested Phrase"
	sleep(2)
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(3)
	end
	
	def mission_logic()
    @driver.find_element(:link, "FB Upload Activity").click
	sleep(1)
    @driver.find_element(:link, "Mission Logic").click
	sleep(1)
    @driver.find_element(:css, "div.mlogic-step.ng-scope").click
	@driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '5') and @class='day']").click
	@driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__586']").click
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
	
 end
  
  def login()
	@driver.get(@config['member']['base_url']	+ "/home")
    @driver.find_element(:link, "or your email address").click
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(5)
	@driver.manage.window.maximize
	sleep(2)
	@driver.save_screenshot "Screenshots/dashboard.png"
	end
def update_shippingaddress()
	#update shipping address
	@driver.find_element(:css, "span.header-user-name").click
	sleep(1)
    @driver.find_element(:link, "Shipping Address").click
	sleep(1)
    @driver.find_element(:id, "member_address_2").clear
    @driver.find_element(:id, "member_address_2").send_keys @config['signup']['address1']
	sleep(1)
    @driver.find_element(:id, "member_address_1").clear
    @driver.find_element(:id, "member_address_1").send_keys @config['signup']['address2']
	sleep(1)
	Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "member_state")).select_by(:text, @config['signup']['state'])
	sleep(1)
    @driver.find_element(:id, "member_city").clear
    @driver.find_element(:id, "member_city").send_keys @config['signup']['city']
	sleep(1)
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys @config['signup']['zip']
	sleep(1)
	Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "member_country")).select_by(:text, "United States")
	sleep(1)
    @driver.find_element(:name, "commit").click
end
def connect_facebook()
	#connect facebook
	@driver.find_element(:css, "span.header-user-name").click
  #if @driver.find_element(:css, "div.col-sm-9").displayed?
  #puts 'connected already'
  #end
   if @driver.find_element(:css, "a.btn.btn-facebook-connect")
   @driver.find_element(:link, "Connect").click
    sleep(1)
	@driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys @config['signup']['email_facebook']
    sleep(2)
    @driver.find_element(:id, "pass").clear
    @driver.find_element(:id, "pass").send_keys @config['signup']['pass_facebook']
    sleep(1)
    @driver.find_element(:id, "u_0_2").click
	puts"element appears"
	else
	puts "element not present"
	end
end
def fb_uploadphoto()
	#goto activity
	
	@driver.find_element(:link, "Dashboard").click
	sleep(2)
	@driver.find_element(:link, "FB Upload Activity").click
	sleep(2)
	@driver.find_element(:xpath, "//*[contains(text(), 'Accept')]").click
	sleep(1)
	#@driver.find_element(:css, "input.btn-color[type='submit']").click
	#sleep(2)
	#@driver.find_element(:css, "input.btn-color[type='submit']").click
	#sleep(4)

	
	buttons = @driver.find_elements(:css, "div.sharing-list-buttons")
	
	#Upload photo to facebook post
	@driver.find_element(:css, 'a[ng-hide="services.upload_photo_facebook.active"]').click
	sleep(2)
	@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, 'input[type="file"]').send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpg")
	sleep(3)
	@driver.find_element(:css, "button.btn.btn-color.btn-autocomplete").click
	sleep(2)
	@driver.find_element(:css,  'textarea[id="shares__text"]').send_keys " member text member text member text member text member text member text"
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox[for='upload_photo_fb_cb']").click
	
	#submit
	@driver.find_element(:css, "button.btn-primary[type='submit']").click
	@driver.find_element(:xpath, "//button[@type='submit']").click
	@driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	@driver.save_screenshot "Screenshots/FB_upload_post.png"
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
