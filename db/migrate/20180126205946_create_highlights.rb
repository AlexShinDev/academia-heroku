class CreateHighlights < ActiveRecord::Migration[5.1]
  def change
    create_table :highlights do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :selection

      t.timestamps
    end
  end
end
