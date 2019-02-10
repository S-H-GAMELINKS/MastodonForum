class AddCategoryToTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :category, :string
  end
end
