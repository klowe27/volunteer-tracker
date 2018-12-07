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
  @volunteers = Volunteer.all
  erb :index
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
  @Volunteer.update({name: new_name, project_id: new_project_id, id: id})
  redirect("/volunteers/#{params["id"]}")
end
