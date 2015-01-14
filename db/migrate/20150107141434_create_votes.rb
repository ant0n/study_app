class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.boolean :vote_flag
      t.references :voteholder, index: true

      t.timestamps
    end
  end
end
