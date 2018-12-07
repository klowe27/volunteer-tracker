require "spec_helper"

describe Volunteer do
  describe '#name' do
    it 'returns the name of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      expect(test_volunteer.name).to eq 'Jane'
    end
  end

  describe '#hours' do
    it 'returns the hours of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      expect(test_volunteer.hours).to eq 4
    end
  end

  describe '#project_id' do
    it 'returns the project_id of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      expect(test_volunteer.project_id).to eq 1
    end
  end

  describe '#==' do
    it 'checks for equality based on the name of a volunteer' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      volunteer2 = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      expect(volunteer1 == volunteer2).to eq true
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Volunteer.all).to eq []
    end

    it 'returns all volunteers' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :hours => 2, :id => nil})
      volunteer2.save
      expect(Volunteer.all).to eq [volunteer1, volunteer2]
    end
  end

  describe '#save' do
    it 'adds a volunteer to the database' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to eq [volunteer1]
    end
  end

  describe '.find' do
    it 'returns a volunteer by id' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :hours => 4, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :hours => 4, :id => nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to eq volunteer1
    end
  end

  describe '#update' do
    it 'allows a user to update a volunteer' do
      volunteer = Volunteer.new({:name => 'Sally', :project_id => 1, :hours => 4, :id => nil})
      volunteer.save
      volunteer.update({:name => 'Rebecca', :project_id => 3, :hours => 6, :id => volunteer.id})
      expect(volunteer.name).to eq 'Rebecca'
      expect(volunteer.project_id).to eq 3
      expect(volunteer.hours).to eq 6
    end
  end

  context '#delete' do
    it 'allows a user to delete a volunteer' do
      volunteer = Volunteer.new({:name => 'Kristin', :project_id => 4, :hours => 4, :id => nil})
      volunteer.save
      volunteer.delete
      expect(Volunteer.all).to eq []
    end
  end

  describe '.sort' do
    it 'returns a list of all volunteers sorted alphabetically' do
      volunteer = Volunteer.new({:name => 'Kristin', :project_id => 4, :hours => 4, :id => nil})
      volunteer.save
      volunteer2 = Volunteer.new({:name => 'Adam', :project_id => 2, :hours => 4, :id => nil})
      volunteer2.save
      expect(Volunteer.sort).to eq [volunteer2, volunteer]
    end
  end

end
