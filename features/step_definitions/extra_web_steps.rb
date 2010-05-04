When /^I follow "([^\"]*)" within frame "([^\"]*)"$/ do |link, frame_id|
  within_frame(frame_id) do
    click_link(link)
  end
end

When /^I fill in "([^\"]*)" with "([^\"]*)" within frame "([^\"]*)"$/ do |field, value, frame_id|
  within_frame(frame_id) do
    fill_in(field, :with => value)
  end
end

When /^I press "([^\"]*)" within frame "([^\"]*)"$/ do |button, frame_id|
  within_frame(frame_id) do
    click_button(button)
  end
end

When /^I select "([^\"]*)" from "([^\"]*)" within frame "([^\"]*)"$/ do |value, field, frame_id|
  within_frame(frame_id) do
    select(value, :from => field)
  end
end

When /^I should see "([^\"]*)" within frame "([^\"]*)"$/ do |text, frame_id|
  within_frame(frame_id) do
    page.should have_content(text)
  end
end

When /^I fill in "([^\"]*)" with "([^\"]*)" within frame "([^\"]*)" for #{capture_model}$/ do |field, value, frame_id, target|
  record = model(target)
  within_frame(frame_id) do
    with_scope("##{dom_id(record)}") do
      fill_in(field, :with => value)
    end
  end
end