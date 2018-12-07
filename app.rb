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

post '/projects/add' do
  title = params['title']
  project = Project.new({title: title, id: nil})
  project.save
  redirect '/'
end

get '/projects/:id' do
  id = params[:id].to_i
  @project = Project.find(id)
  erb :project
end

get '/projects/:id/edit' do
  id = params[:id].to_i
  @project = Project.find(id)
  erb :project_edit
end

patch '/projects/:id/update' do
  id = params[:id].to_i
  @project = Project.find(id)
  new_title = params['title']
  @project.update({title: new_title, id: id})
  redirect('/')
  # redirect('/projects/#{id}')
end
