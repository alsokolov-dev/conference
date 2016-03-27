class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :affiliation
      t.string :country
      t.string :student
      t.integer :age
      t.text :background
      t.text :abstract
      t.string :password_digest
      t.string :remember_digest

      t.timestamps null: false
    end

    add_index :students, :email, unique: true
    add_column :students, :activation_digest, :string
    add_column :students, :activated, :boolean, default: false
    add_column :students, :activated_at, :datetime
    add_column :students, :reset_digest, :string
    add_column :students, :reset_sent_at, :datetime
  end
end
