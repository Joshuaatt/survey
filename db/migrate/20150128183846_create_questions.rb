class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :prompt, :string

      t.timestamps
    end
  end
end
