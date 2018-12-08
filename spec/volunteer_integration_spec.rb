require "capybara/rspec"
require "./app"
require "pry"
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    fill_in('title', :with => 'Teaching Kids to Code')
    click_button('Create Project')
    expect(page).to have_content('Teaching Kids to Code')
  end
end

describe 'the project detail page path', {:type => :feature} do
  it 'shows a project detail page' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit "/projects/#{test_project.id}"
    expect(page).to have_content('Teaching Kids to Code')
  end
end

describe 'the project update path', {:type => :feature} do
  it 'allows a user to change the name of the project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    fill_in('title', :with => 'Teaching Ruby to Kids')
    click_button('Update Project')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end

describe 'the project delete path', {:type => :feature} do
  it 'allows a user to delete a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}"
    click_button('Delete Project')
    expect(page).not_to have_content("Teaching Kids to Code")
  end
end

describe 'the Volunteer creation path', {:type => :feature} do
  it 'lets a user add a volunteer' do
    project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    project.save
    id = project.id
    visit '/'
    fill_in('name', :with => 'Jelly')
    fill_in('hours', :with => 20)
    select(project.title, :from => 'project_id')
    click_button('Add Volunteer')
    expect(page).to have_content('Jelly')
  end
end

describe 'the volunteer detail page path', {:type => :feature} do
  it 'shows a volunteer detail page' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :hours => 4, :id => nil})
    test_volunteer.save
    visit "/projects/#{project_id}"
    click_link('Jasmine')
    fill_in('name', :with => 'Jane')
    fill_in('hours', :with => 8)
    click_button('Update Volunteer')
    expect(page).to have_content('Jane')
  end
end

describe 'the volunteer delete path', {:type => :feature} do
  it 'allows a user to delete a volunteer' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :hours => 4, :id => nil})
    test_volunteer.save
    id = test_volunteer.id
    visit "/volunteers/#{id}"
    click_button('Delete Volunteer')
    expect(page).not_to have_content('Jasmine')
  end
end

describe 'the volunteer update path', {:type => :feature} do
  it 'allows a user to change the name, hours and project of the volunteer' do
    project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    project.save
    id = project.id
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => id, :hours => 4, :id => nil})
    test_volunteer.save
    visit '/'
    click_link('Jasmine')
    fill_in('name', :with => 'Kelly')
    fill_in('hours', :with => 10)
    select(project.title, :from => 'project_id')
    click_button('Update Volunteer')
    expect(page).to have_content('Kelly')
  end
end
