require 'spec_helper'

describe Place do
  it "shouldn't create empty Place" do
  	p = Place.create({"description" => nil, "name" => nil})
  	p.should_not be_valid
  	p.errors[:description].should_not be_empty
  	p.errors[:name].should_not be_empty
  end

  it "should set default values" do
  	p = Place.create({"description" => "foo", "name" => "bar"})
  	p.should be_respond_to(:set_default_values)
  	p.temp.should be_false
  end

end