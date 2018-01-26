class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :author
      t.string :url
      t.string :publisher
      t.string :date_published
      t.string :medium
      t.text :content
      t.string :image
      t.string :summary
      t.integer :user_id

      t.timestamps
    end
  end
end
