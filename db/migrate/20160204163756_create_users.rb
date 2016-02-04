class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :organization_name
      t.string :department
      t.string :position
      t.text :area_of_interest
      t.string :presentation
      t.text :abstract
      t.boolean :visa_sponsorship
      t.boolean :hotel

      t.timestamps null: false
    end
  end
end
