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
	check_activity()
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
    @driver.find_element(:xpath, "//div[@id='new_mission_hub']/div/div/div[2]/div/div/input").send_keys "Sharing Tools"
	sleep(1)
	@driver.find_element(:css, "button.btn-default").click
	@driver.find_element(:css, "li.test-hub-new-activity").click
	sleep(3)
    @driver.find_element(:link, "New Activity").click
	sleep(7)
    @driver.find_element(:css, "button.btn-edit").click
	sleep(2)
	@driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").clear
	@driver.find_element(:css, "input.ng-pristine[placeholder='Type a activity name']").send_keys "Sharing Tools Activity"
	
	sleep(4)
    @driver.find_element(:css, "textarea.mission-page-title").clear
	
	sleep(2)

    @driver.find_element(:css, "textarea.mission-page-title").send_keys "Sharing Tools Activity"
	sleep(1)
	@driver.find_element(:css, "input.mission-goal").clear
	@driver.find_element(:css, "input.mission-goal").send_keys "10"
	
	#scroll
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	
	#Toggle Facebook
    @driver.find_element(:id, "switch_cb_facebook").click
	sleep(4)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook.seed_url']").clear
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.facebook.seed_url']").send_keys "http://socialmedialink.com/"
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.facebook.suggested_phrase']").send_keys "Suggested Phrase"
	sleep(1)
	
	#Toggle Twitter
    @driver.find_element(:id, "switch_cb_twitter").click
	sleep(1)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.twitter.seed_url']").clear
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.twitter.seed_url']").send_keys "http://socialmedialink.com/"
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.seed_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.seed_phrase']").send_keys "Seed Phrase"
	sleep(1)
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.suggested_phrase']").clear
	@driver.find_element(:css, "textarea.ng-pristine[ng-model='activity.twitter.suggested_phrase']").send_keys "Suggested Phrase"
	sleep(2)
	
	#Toggle Face2face
    @driver.find_element(:id, "switch_cb_face2face").click
	sleep(2)
	
	#Toggle Upload Facebook
	@driver.find_element(:id, "switch_cb_upload_photo_facebook").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_facebook.suggested_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_facebook.suggested_phrase']").send_keys "Upload photo to facebook suggested Phrase"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Toggle Upload Twitter
	@driver.find_element(:id, "switch_cb_upload_photo_twitter").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.seed_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.seed_phrase']").send_keys "Upload photo to twitter seed Phrase"
	sleep(2)
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.suggested_phrase']").clear
	@driver.find_element(:css, "textarea[ng-model='activity.upload_photo_twitter.suggested_phrase']").send_keys "Upload photo to twitter suggested Phrase"
	
	#scroll
	@driver.execute_script("scroll(0, 750);")
	sleep(4)
	
	#Toggle Blog
	@driver.find_element(:id, "switch_cb_blog").click
	sleep(2)

	#Toggle Youtube
	@driver.find_element(:id, "switch_cb_youtube").click
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(1)
	
	
	#Toggle Pinterest
	@driver.find_element(:id, "switch_cb_pinterest").click
	sleep(2)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.pinterest.seed_url']").send_keys "https://smiley.socialmedialink.com"
	sleep(1)
	@driver.find_element(:css, "textarea[ng-model='activity.pinterest.suggested_phrase']").send_keys "Click this pin to visit Smiley360! You'll love being a member :)"
	@driver.execute_script('$(\'input.js-pinterest-image[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.js-pinterest-image[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpg")
	sleep(3)
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#Toggle Instagram
	@driver.find_element(:id, "switch_cb_instagram").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 2000);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.instagram.seed_phrase']").send_keys "Share Smiley360 with your Instagram followers! Submit a link to your Instagram photo in the box below for 10 points. <em>Links must follow the format http://instagram.com/p/xxxxxxxxxx</em>"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)

	#Toggle Brandconnect
	@driver.find_element(:id, "switch_cb_brand_connect").click
	sleep(2)
	#scroll
	@driver.execute_script("scroll(0, 2400);")
	sleep(4)
	#@driver.find_element(:id, "s2id_topic-search").find_element(:css,"option[value='1']").click
	@driver.find_element(:id, "s2id_topic-search").click
	@driver.find_element(:id, "select2-results-3").click
	
	#scroll
	@driver.execute_script("scroll(0, 1000);")
	sleep(4)
	
	#Toggle retail review
	@driver.find_element(:id, "switch_cb_retail_review").click
	sleep(1)
	#scroll
	@driver.execute_script("scroll(0, 2800);")
	sleep(4)
	@driver.find_element(:css, "textarea[ng-model='activity.retail_review.seed_phrase']").send_keys "Retail Review Instructions Retail Review Instructions Retail Review Instructions Retail Review Instructions"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1200);")
	sleep(4)
	
	#Toggle Share A Link
	@driver.find_element(:id, "switch_cb_share_link").click
	sleep(1)
	#scroll
	@driver.execute_script("scroll(0, 3000);")
	sleep(4)
	@driver.find_element(:css, "input.activity-share-url[ng-model='activity.share_link.seed_url']").send_keys "http://smiley.socialmedialink.com/promo/fp"
	sleep(2)
	
	#scroll
	@driver.execute_script("scroll(0, 1200);")
	sleep(4)
	
	
	#save
    @driver.find_element(:css, "button.btn.btn-sidebar.btn-primary").click
	sleep(3)
	end
	def mission_logic()
    @driver.find_element(:link, "Sharing Tools").click
	sleep(1)
    @driver.find_element(:link, "Mission Logic").click
	sleep(1)
    @driver.find_element(:css, "div.mlogic-step.ng-scope").click
	@driver.find_element(:id, "date-start").click
	@driver.find_element(:xpath, "//td[contains(text(), '6') and @class='day']").click
	@driver.find_element(:css, "button.mlogic-add-group").click
	@driver.find_element(:css, "label.control-checkbox-primary[for='checkbox__535']").click
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
  
  def check_activity()
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
	@driver.find_element(:link, "Sharing Tools Activity").click
	sleep(2)
	@driver.find_element(:xpath, "//*[contains(text(), 'Accept')]").click
	sleep(1)
	#@driver.find_element(:css, "input.btn-color[type='submit']").click
	#sleep(2)
	#@driver.find_element(:css, "input.btn-color[type='submit']").click
   

=begin 
	#use the below code when the member is not connected to Facebook
	@driver.find_element(:link, "connect").click
	sleep(1)
	
	#use the below code when the member is not connected to twitter
	@driver.find_element(:link, "connect").click
	sleep(1)
	@driver.find_element(:id, "username_or_email").clear
    @driver.find_element(:id, "username_or_email").send_keys "tripthishetty20@gmail.com"
	sleep(1)
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "general1234"
	sleep(1)
	@driver.find_element(:id, "allow").click
	sleep(2)
=end
	
	buttons = @driver.find_elements(:css, "div.sharing-list-buttons")
	
	#Facebook post
	buttons[0].find_element(:css, 'a').click
	#@driver.execute_script("scroll(0, 250);")
	#sleep(1)
	@driver.find_element(:css, "button.btn-color[sml-text-target='.js-facebook-phrase-target']").click
	sleep(1)
	textareas = @driver.find_elements(:css, "div.relative")
	textareas[0].find_element(:css, 'textarea').send_keys " member text member text member text member text member text member text"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='facebook_fb_cb']").click
	sleep(1)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	
	#Twitter post
	buttons[1].find_element(:css, 'a').click
	sleep(2)
    textareas[1].find_element(:css,  'textarea').send_keys " member text"
	sleep(1)
	
	#Blog Review
	buttons[2].find_element(:css, 'a').click
	sleep(2)
	#textareas1 = @driver.find_elements(:css, "div.sharing-list-form")
	@driver.find_element(:css, "textarea[placeholder='Paste the link to your blog post here']").send_keys "http://blog.smiley360.com/"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='blog_cb']").click
	
	
	#Face2face post
	buttons[3].find_element(:css, 'a').click
	sleep(2)
	textareas[2].find_element(:css, 'textarea').send_keys "face2face member text face2face member text face2face member text face2face member text face2face member text"
	sleep(2)
	
	
=begin	
	textareas = @driver.find_elements(:css, "div.relative")
	textareas[0].find_element(:css, 'textarea').send_keys " member text member text member text member text member text member text"
	sleep(2)
	@driver.execute_script('$(\'input.js-pinterest-image[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input.js-pinterest-image[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpg")
	sleep(3)
=end

	#upload photo to twitter post
	buttons[4].find_element(:css, 'a').click
	sleep(2)
	
	@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, 'input[type="file"]').send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpg")
	sleep(3)
	textareas[3].find_element(:css,  'textarea').send_keys " member text"
	sleep(1)
=begin
	#Upload photo to facebook post
	buttons[5].find_element(:css, 'a').click
	sleep(2)
	@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, 'input[type="file"]').send_keys("C:\\Users\\Tripthi\\Pictures\\admin.jpg") 
	sleep(3)
	@driver.find_element(:css, "button.btn.btn-color.btn-autocomplete").click
	sleep(2)
	textareas[4].find_element(:css,  'textarea').send_keys " member text"
	sleep(1)
	@driver.find_element(:css, "label.control-checkbox[for='upload_photo_fb_cb']").click
	
=end

	
	
	#Youtube
	buttons[6].find_element(:css, 'a').click
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Paste the link to your video here']").send_keys "https://youtu.be/_UR-l3QI2nE"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='youtube_cb']").click
	
	#Brand connect
	buttons[7].find_element(:css, 'a').click
	sleep(2)
	textareas[5].find_element(:css,  'textarea').send_keys "Brand connect comment Brand connect comment Brand connect comment Brand connect comment"
	sleep(2)
	
	#Pinterest
	buttons[9].find_element(:css, 'a').click
	sleep(2)
	textareas[6].find_element(:css,  'textarea').send_keys "https://www.pinterest.com/pin/457889487091108197/"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='pinterest_cb']").click
	
	#Instagram
	buttons[10].find_element(:css, 'a').click
	sleep(2)
	@driver.find_element(:css, "textarea[placeholder='Please paste the link to your Instagram here']").send_keys "https://youtu.be/_UR-l3QI2nE"
	sleep(2)
	@driver.find_element(:css, "label.control-checkbox[for='instagram_cb']").click
	
	
	#submit
	@driver.find_element(:css, "button.btn-primary[type='submit']").click
	@driver.find_element(:xpath, "//button[@type='submit']").click
	@driver.find_element(:xpath, "(//button[@type='button'])[2]").click
	@driver.save_screenshot "Screenshots/sharingtools_posts.png"
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
