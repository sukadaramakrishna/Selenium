require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations
require "yaml"


describe "Todelete" do

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
  
  it "test_todelete" do
  #postToFacebook()
  likeShareCommentFb()
  end
  def postToFacebook()
    @driver.get(@base_url + "/home")
	sleep(2)
	#signin
	@driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['member']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['member']['pass']
    @driver.find_element(:name, "commit").click
	sleep(5)
	@driver.manage.window.maximize
	sleep(2)
	#Redirect to the activity
	@driver.find_element(:link, "Sharing Tools Activity").click
	#Add post to Fb
    #@driver.find_element(:link, "Add post").click
	@driver.find_element(:css, "a.sharing-list-buttons-show").click
    @driver.find_element(:xpath, "//button[@type='button']").click
    @driver.find_element(:id, "shares__text").clear
    @driver.find_element(:id, "shares__text").send_keys "auto l s c Suggested Phrase Suggested Phrase Suggested Phrase Suggested Phrase Suggested Phrase Suggested Phrase"
    sleep(2)
	@driver.execute_script("scroll(0, 250);")
	sleep(4)
	@driver.find_element(:css, "label.control-checkbox").click
	sleep(1)
	@driver.execute_script("scroll(0, 1500);")
	sleep(4)
    @driver.find_element(:xpath, "//button[@type='submit']").click
	sleep(1)
	end
	def likeShareCommentFb()
	#Redirect to Facebook
	@driver.get("https://www.facebook.com/")
	sleep(2)
	@driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys @config['signup']['email_facebook']
    sleep(2)
    @driver.find_element(:id, "pass").clear
    @driver.find_element(:id, "pass").send_keys @config['signup']['pass_facebook']
    sleep(1)
    @driver.find_element(:id, "loginbutton").click
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
	#click the name tag
    @driver.find_element(:xpath, "//div[@id='pagelet_welcome_box']/ul/li/div/a").click
	sleep(2)
	
	#scroll down
	@driver.execute_script("scroll(0, 100);")
	sleep(2)
	
	#Like first post
    @driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[1]").click
	#@driver.find_element(:xpath, "(//div[@class='_2r6l']").click
	sleep(2)
	
    #scroll dowm further
	@driver.execute_script("scroll(0, 150);")
	sleep(2)
	
	#Like second post
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[1]").click
	sleep(2)

=begin
	#Comment on the first post
	@driver.find_element(:xpath, "(//div[@class='UFIAddCommentInput _1osb _5yk1'])[1]/div/div/div[2]/div/div/div/div").click
	@driver.find_element(:xpath, "(//div[@class='UFIAddCommentInput _1osb _5yk1'])[1]/div/div/div[2]/div/div/div/div").send_keys "comment1"
	sleep(2)
=end
	#scroll up
	@driver.execute_script("scroll(100, 0);")
	sleep(2)
	
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[2]").click
	sleep(2)
	
	#scroll down
	@driver.execute_script("scroll(0, 50);")
	sleep(2)
	
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[2]").click
	sleep(2)
	
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[1]/div/div[1]").click
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[1]/div/div[1]").send_keys "comment1"
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[2]/div/div[1]").click
	#@driver.find_element(:xpath, "//div[contains(@id,'addComment_')])[2]/div/div[1]").send_keys "comment2"
	#@driver.find_element(:xpath, "(//div[contains(@id,'addComment_')])[1]/div/div[2]/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div").click
	#@driver.find_element(:xpath, "(//div[contains(@id,'addComment_')])[1]/div/div[2]/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div").send_keys "comment1"
	#@driver.find_element(:xpath, "(//div[@class='UFIList'])[1]/div[2]/div/div[2]/div/div/div/div/input").click
	#@driver.find_element(:xpath, "(//div[@class='UFIRow._4oep.UFIAddComment.UFIAddCommentWithPhotoAttacher._2o9m'])[1]").click
	#@driver.find_element(:xpath, "(//div[@class='UFIRow._4oep.UFIAddComment.UFIAddCommentWithPhotoAttacher._2o9m'])[1]").send_keys "comment1"
	#element.equals(driver.switchTo().activeElement()).send_keys "comment"
	#@driver.find_element(:css, "//div[@id='u_0_2u']/div/div[3]/div/div[2]/div/div/div/div[1]").click
	#@driver.find_element(:css, "//div[@id='u_0_2u']/div/div[3]/div/div[2]/div/div/div/div[1]").send_keys "comment1"
	
	@driver.action.send_keys(:enter).perform
	sleep(2)
	#scroll up
	@driver.execute_script("scroll(100, 0);")
	sleep(2)
	#Share the post
    @driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[3]").click
	#click share from the dropdown
    @driver.find_element(:xpath, "(//div[@class='_54ng'])[1]/ul/li[2]/a/span/span").click
	#Post the share
    @driver.find_element(:xpath, "//div[@class='_4-88']/button[2]").click
	sleep(4)
	#scroll
	@driver.execute_script("scroll(0, 50);")
	sleep(2)
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[3]").click
	#click share from the dropdown
    @driver.find_element(:xpath, "(//div[@class='_54ng'])[2]/ul/li[2]/a/span/span").click
	#Post the share
    @driver.find_element(:xpath, "//div[@class='_4-88']/button[2]").click
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
