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
  likeRetweetTw()
  end
 
	def likeRetweetTw()
	#Redirect to Facebook
	@driver.get("https://twitter.com/")
	sleep(3)
	@driver.find_element(:xpath, "//div[@class='StreamsHero-buttonContainer']/a[3]").click
	sleep(2)
	@driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-username']/input").clear
    @driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-username']/input").send_keys @config['signup']['email_twitter']
    sleep(2)
	
    @driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-password']/input").clear
    @driver.find_element(:xpath, "//div[@class='LoginForm-input LoginForm-password']/input").send_keys @config['signup']['pass_twitter']
    sleep(1)
    @driver.find_element(:css, "input.submit.btn.primary-btn.js-submit").click
	sleep(2)
	@driver.manage.window.maximize
	sleep(2)
	#click the name tag
    @driver.find_element(:css, "a.u-textInheritColor").click
	sleep(2)
	@driver.execute_script("scroll(0, 400);")
	sleep(2)

	#Like the post 1
    @driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--favorite js-toggleState'])[1]/button[1]").click
	sleep(2)
	#Like the post 2
	@driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--favorite js-toggleState'])[2]/button[1]").click
	sleep(2)
	#retweet post 1
	@driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--retweet js-toggleState js-toggleRt'])[1]/button[1]").click
	sleep(2)
	@driver.find_element(:css, "button.btn.primary-btn.retweet-action").click
	sleep(2)
	#retweet post 2
	@driver.find_element(:xpath, "(//div[@class='ProfileTweet-action ProfileTweet-action--retweet js-toggleState js-toggleRt'])[2]/button[1]").click
	sleep(2)
	@driver.find_element(:css, "button.btn.primary-btn.retweet-action").click
	sleep(2)

=begin
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[1]").click
	sleep(2)
	#Comment on the post
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[2]").click
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
	
	#Share the post
    @driver.find_element(:xpath, "(//div[@class='_42nr'])[1]/span[3]").click
	#click share from the dropdown
    @driver.find_element(:xpath, "(//div[@class='_54ng'])[1]/ul/li[2]/a/span/span").click
	#Post the share
    @driver.find_element(:xpath, "//div[@class='_4-88']/button[2]").click
	sleep(4)
	@driver.find_element(:xpath, "(//div[@class='_42nr'])[2]/span[3]").click
	#click share from the dropdown
    @driver.find_element(:xpath, "(//div[@class='_54ng'])[2]/ul/li[2]/a/span/span").click
	#Post the share
    @driver.find_element(:xpath, "//div[@class='_4-88']/button[2]").click
=end
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
