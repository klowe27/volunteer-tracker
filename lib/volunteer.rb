class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(another_object)
    self.id.==(another_object.id).&self.name.==(another_object.name)
  end
end
