class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :chat_room, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
