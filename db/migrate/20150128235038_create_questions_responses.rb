class CreateQuestionsResponses < ActiveRecord::Migration
  def change
    create_table :questions_responses do |t|
      t.column :question_id, :integer
      t.column :response_id, :integer

      t.timestamps
    end
  end
end
