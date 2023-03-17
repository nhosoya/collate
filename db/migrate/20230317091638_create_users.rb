class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name_a, collation: 'utf8mb4_bin', index: { unique: true }
      t.string :name_b, collation: 'utf8mb4_general_ci', index: { unique: true }
      t.string :name_c, collation: 'utf8mb4_unicode_ci', index: { unique: true }

      t.timestamps
    end
  end
end
