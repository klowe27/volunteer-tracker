class Volunteer
  attr_reader :name, :project_id, :hours, :id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @hours = attributes[:hours]
    @id = attributes[:id]
  end

  def self.all
    volunteers_db = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    volunteers_db.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      hours = volunteer["hours"].to_i
      volunteers.push(Volunteer.new({
        name: name,
        project_id: project_id,
        hours: hours,
        id: id}))
    end
    volunteers
  end

  def self.sort
    volunteers_db = DB.exec("SELECT * FROM volunteers ORDER BY name;")
    volunteers = []
    volunteers_db.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      hours = volunteer["hours"].to_i
      volunteers.push(Volunteer.new({
        name: name,
        project_id: project_id,
        hours: hours,
        id: id}))
    end
    volunteers
  end

  def self.sort_by_hours
    volunteers_db = DB.exec("SELECT * FROM volunteers ORDER BY hours;")
    volunteers = []
    volunteers_db.each do |volunteer|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      id = volunteer["id"].to_i
      hours = volunteer["hours"].to_i
      volunteers.push(Volunteer.new({
        name: name,
        project_id: project_id,
        hours: hours,
        id: id}))
    end
    volunteers
  end

  def self.find(volunteer_id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id}")
    Volunteer.new({
      name: result.first["name"],
      project_id: result.first["project_id"].to_i,
      hours: result.first["hours"].to_i,
      id: result.first["id"].to_i})
  end

  def save
    @id = DB.exec("INSERT INTO volunteers (name, project_id, hours) VALUES ('#{@name}', #{@project_id}, #{@hours}) RETURNING id;").first["id"].to_i
  end

  def update(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @hours = attributes[:hours]
    DB.exec("UPDATE volunteers SET name = '#{@name}', project_id = #{@project_id}, hours = #{@hours} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id}")
  end

  def ==(another_object)
    self.id.==(another_object.id).&self.name.==(another_object.name)
  end

end
