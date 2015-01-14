class CreateVoteholders < ActiveRecord::Migration
  def change
    create_table :voteholders do |t|
      t.references :votable, polymorphic: true, index: true
      t.integer :vote_count, default: 0

      t.timestamps
    end
  end
end
