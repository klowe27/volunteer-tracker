class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
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

  def self.find(project_id)
    result = DB.exec("SELECT * FROM projects WHERE id = #{project_id}")
    Project.new({title: result.first["title"], id: result.first['id'].to_i})
  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first["id"].to_i
  end

  def update(attributes)
    @title = attributes[:title]
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id}")
  end

  def volunteers
    volunteers_db = DB.exec("SELECT * FROM volunteers WHERE project_id = #{id};")
    volunteers = []
    volunteers_db.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      volunteers.push(Volunteer.new({name: name, project_id: project_id, id: id}))
    end
    volunteers
  end

  def ==(another_object)
    self.id.==(another_object.id).&self.title.==(another_object.title)
  end
end
