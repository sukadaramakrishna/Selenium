require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "TrainingWikipediaExercise" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://www.wikipedia.org/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    #@driver.quit
    @verification_errors.should == []
  end
  
  it "test_training_wikipedia_exercise" do
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "searchInput").clear
    @driver.find_element(:id, "searchInput").send_keys "selenium software"
    @driver.find_element(:name, "go").click
    @driver.find_element(:css, "ul.mw-search-results li:nth-of-type(1) a").click
	verify { assert(@driver.find_element(:css, "//upload.wikimedia.org/wikipedia/en/5/5c/Seleniumlogo.png").text.include?("Name"),"Page contains the text NAME")}
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
