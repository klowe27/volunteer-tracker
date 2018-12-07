require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/project')
require('./lib/volunteer')
require('pg')
require('pry')

DB = PG.connect({dbname: 'volunteer_tracker'})

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
