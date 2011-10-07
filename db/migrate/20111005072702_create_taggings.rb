class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :article
      t.belongs_to :tag

      t.timestamps
    end
  end
end
