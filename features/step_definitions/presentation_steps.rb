Given /^I have two organizations created named (.+)$/ do |names|
  names.split(', ').each do |name|
    Organization.create!({:name=>name})
  end
end

Then /^I should see the organizations allowed$/ do
  Organization.all
end

Then /^the Strategies allowed$/ do
  Strategy.all
end