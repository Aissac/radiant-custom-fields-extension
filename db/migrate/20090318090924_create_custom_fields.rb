class CreateCustomFields < ActiveRecord::Migration
  def self.up
    create_table :custom_fields do |t|
      t.column    :name,          :string
      t.column    :value,         :string
      t.column    :page_id,       :integer
      t.timestamps
    end
    add_index :custom_fields, [:name, :page_id]
    add_index :custom_fields, :name
    add_index :custom_fields, :value
  end

  def self.down
    drop_table :custom_fields
  end
end
