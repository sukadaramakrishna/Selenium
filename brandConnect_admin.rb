require "json"
require "selenium-webdriver"
require "rspec"
require "yaml"
include RSpec::Expectations

describe "CreteBrandConnect" do

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
  
  it "test_crete_brand_connect" do
  login()
  #filldetails()
  createtopic()
  creatediscussion()
  editBrandconnectDiscussion()
  editBrandconnectTopic()
  new2Old()
  end
  
  def login()
    @driver.get(@config['member']['base_url']	+ "/home")
	#login
    @driver.find_element(:id, "member_email").clear
    @driver.find_element(:id, "member_email").send_keys @config['admin']['email']
    @driver.find_element(:id, "member_password").clear
    @driver.find_element(:id, "member_password").send_keys @config['admin']['pass']
    @driver.find_element(:name, "commit").click
	sleep(5)
	@driver.manage.window.maximize
	sleep(2)
	end
	
	def filldetails()
	#Fill up details
	@driver.find_element(:id, "member_first_name").clear
    @driver.find_element(:id, "member_first_name").send_keys "admin"
	sleep(2)
    @driver.find_element(:id, "member_last_name").clear
    @driver.find_element(:id, "member_last_name").send_keys "admin"
	sleep(2)
    @driver.find_element(:id, "member_zip_code").clear
    @driver.find_element(:id, "member_zip_code").send_keys "10018"
	sleep(2)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_month")).select_by(:text, "February")
	sleep(1)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_day")).select_by(:text, "7")
	sleep(1)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "date_year")).select_by(:text, "1991")
	sleep(3)
    @driver.find_element(:xpath, "(//label[@class='control-radio'])[1]").click
	sleep(2)
    @driver.find_element(:name, "commit").click
	end
	
	def createtopic()
	#Create topic
    @driver.find_element(:link, "Brand Connect").click
    @driver.find_element(:link, "Create Topic").click
	sleep(2)
	@driver.execute_script('$(\'input[type="file"]\').attr("style", "");');
	sleep(1)
	@driver.find_element(:css, "input[type='file']").send_keys("C:\\Users\\Tripthi\\Pictures\\Brandconnect.jpe")
	sleep(5)
	
    @driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title 1 just created"
	sleep(2)
    @driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title 1 just created created"
    sleep(2)
	@driver.find_element(:name, "commit").click
	puts "Brand connect topic created."
	end
	
	def creatediscussion()
	#Create discussion
    @driver.find_element(:link, "Start the Discussion").click
	sleep(2)
    @driver.find_element(:id, "discussion_title").clear
    @driver.find_element(:id, "discussion_title").send_keys "Discussion 1 just created"
    sleep(2)
	@driver.find_element(:id, "discussion_first_comment_attributes_text").clear
    @driver.find_element(:id, "discussion_first_comment_attributes_text").send_keys "Message created"
    sleep(2)
	@driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/brandconnectDicussion_created.png"
	puts "Brand connect discussion created successfully."
	end
	
	def editBrandconnectDiscussion()
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label").click
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label/span/a[1]").click
	sleep(1)
	@driver.find_element(:id, "discussion_title").clear
    @driver.find_element(:id, "discussion_title").send_keys "Discussion 1 just edited"
    sleep(2)
	@driver.find_element(:id, "discussion_first_comment_attributes_text").clear
    @driver.find_element(:id, "discussion_first_comment_attributes_text").send_keys "Message edited"
    sleep(2)
	@driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/brandconnectDicussion_edited.png"
	puts "Brand connect discussion edited successfully."
	end 
	
	def editBrandconnectTopic()
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/h1/a[2]").click
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label").click
	sleep(1)
	@driver.find_element(:xpath, "//div[@class='bconnect-topic-header-title']/label/span/a[1]").click
	sleep(1)
	@driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title 1 just edited"
	sleep(2)
    @driver.find_element(:id, "topic_title").clear
    @driver.find_element(:id, "topic_title").send_keys "Title 1 just edited"
    sleep(2)
	@driver.find_element(:name, "commit").click
	@driver.save_screenshot "Screenshots/brandconnectTopic_edited.png" 
    puts "Brandconnect topic edited successfully."
	
	end 
	
	def new2Old()
	@driver.find_element(:css, "a.bconnect-discussions-title").click
	sleep(2)
	(0..31).each do |i|
	@driver.find_element(:xpath, "//textarea").clear
    @driver.find_element(:xpath, "//textarea").send_keys "comment #{i}"
	sleep(1)
	@driver.find_element(:css, "a.btn.btn-color.btn-md.bconnect-new-post-submit").click
	sleep(2)
	end
	@driver.save_screenshot "Screenshots/brandconnectNew2OldComments.png" 
	puts "added 31 comments"
	puts "Test passed"
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
