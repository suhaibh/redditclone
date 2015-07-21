require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  def setup
  	@link = Link.new(title: "Link Title", url: "www.link.com", description: "Link description")
  end

  test "link should be valid" do
     assert @link.valid?
  end

  test "link without title should be invalid" do
  	@link.title = ""
  	assert @link.invalid?
  end

  test "link wihtout url should be invalid" do
  	@link.url = ""
  	assert @link.invalid?
  end

  test "link without description should be invalid" do
  	@link.description = ""
  	assert @link.invalid?
  end

  test "link with long title should be invalid" do
  	@link.title = "a" * 201
  	assert @link.invalid?
  end

  test "link with long description should be invalid" do
  	@link.description = "a" * 10001
  	assert @link.invalid?
  end

end
