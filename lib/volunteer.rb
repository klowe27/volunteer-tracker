class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def self.all
    volunteers_db = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    volunteers_db.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      volunteers.push(Volunteer.new({name: name, project_id: project_id, id: id}))
    end
    volunteers
  end

  def self.find(volunteer_id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id}")
    Volunteer.new({name: result.first["name"], project_id: result.first["project_id"].to_i, id: result.first["id"].to_i})
  end

  def save
    @id = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;").first["id"].to_i
  end

  def update(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    DB.exec("UPDATE volunteers SET name = '#{@name}', project_id = #{@project_id} WHERE id = #{@id};")

  end

  def ==(another_object)
    self.id.==(another_object.id).&self.name.==(another_object.name)
  end
end
