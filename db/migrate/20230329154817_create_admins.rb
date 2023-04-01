class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :encryped_password, null: false
      
      t.timestamps
    end
  end
end
