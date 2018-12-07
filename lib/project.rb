class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    projects_db = DB.exec("SELECT * FROM projects;")
    projects = []
    projects_db.each do |project|
      title = project["title"]
      id = project["id"].to_i
      projects.push(Project.new({title: title, id: id}))
    end
    projects
  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first["id"].to_i
  end

  def ==(another_object)
    self.id.==(another_object.id).&self.title.==(another_object.title)
  end
end
