class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :title
      t.timestamps
    end

    create_table :toys_tags do |t|
      t.integer :toy_id
      t.integer :tag_id
    end
  end
end
