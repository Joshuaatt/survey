class Survey < ActiveRecord::Base
  has_and_belongs_to_many :questions
  before_save(:capitalize_name)

private

  def capitalize_name
    self.name=name.capitalize
  end
end
