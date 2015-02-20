class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.belongs_to :playlist
      t.integer :duration

      t.timestamps
    end
  end
end
