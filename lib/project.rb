class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
    @id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;").first["id"].to_i
  end

  def ==(another_object)
    self.id.==(another_object.id).&self.title.==(another_object.title)
  end
end
