class Question < ActiveRecord::Base
  has_and_belongs_to_many :surveys
  has_and_belongs_to_many :responses

  validates(:prompt, :presence => true)
end
