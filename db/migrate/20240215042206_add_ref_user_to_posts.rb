class AddRefUserToPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :user_id, :integer

    add_reference :posts, :user, null: false, foreign_key: true
  end
end
