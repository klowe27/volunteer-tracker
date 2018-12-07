require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/project')
require('./lib/volunteer')
require('pg')
require('pry')

# DB = PG.connect({dbname: 'volunteer_tracker'})

get '/' do
  @projects = Project.all
  erb :index
end

get '/search' do
  params['search']
  
end

post '/projects/add' do
  title = params['title']
  project = Project.new({title: title, id: nil})
  project.save
  redirect '/'
end

get '/projects/:id' do
  id = params[:id].to_i
  @project = Project.find(id)
  @volunteers = @project.volunteers
  erb :project
end

patch '/projects/:id/edit' do
  id = params[:id].to_i
  @project = Project.find(id)
  new_title = params['title']
  @project.update({title: new_title, id: id})
  redirect("/projects/#{params["id"]}")
end

patch '/projects/:id/delete' do
  id = params[:id].to_i
  project = Project.find(id)
  project.delete
  redirect '/'
end

get '/sort' do
  @projects = Project.sort
  erb :index
end

get '/projects/:id/sort_volunteers' do
  project_id = params[:id].to_i
  @project = Project.find(project_id)
  @volunteers = @project.volunteers_sort
  erb :project
end

post '/volunteers/add' do
  name = params['name']
  project_id = params['project_id']
  volunteer = Volunteer.new({name: name, project_id: project_id, id: nil})
  volunteer.save
  redirect '/'
end

get '/volunteers/:id' do
  id = params[:id].to_i
  @projects = Project.all
  @volunteer = Volunteer.find(id)
  @project = Project.find(@volunteer.project_id)
  erb :volunteer
end

patch '/volunteers/:id/edit' do
  id = params[:id].to_i
  @volunteer = Volunteer.find(id)
  new_name = params['name']
  new_project_id = params['project_id']
  @volunteer.update({name: new_name, project_id: new_project_id, id: id})
  redirect("/volunteers/#{id}")
end

patch '/volunteers/:id/delete' do
  id = params[:id].to_i
  volunteer = Volunteer.find(id)
  volunteer.delete
  redirect("/")
end
