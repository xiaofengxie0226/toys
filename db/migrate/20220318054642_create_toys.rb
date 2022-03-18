class CreateToys < ActiveRecord::Migration[7.0]
  def change
    create_table :toys do |t|
      t.string :toyname
      t.text :description
      t.string :url
      t.boolean :is_public,default: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
