class AddVersionateTdepositos < ActiveRecord::Migration

  def self.up
    Tdeposito.create_versioned_table
  end

  def self.down
    drop_table :tdeposito_versions
  end
  
end
