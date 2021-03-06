class CreateUserProfile < ActiveRecord::Migration
  def change
    create_table "user_profiles", force: true do |t|
      t.integer "vk_id", null: false
      t.integer "status", default: 0
      t.integer "friends_count"
      t.timestamps
      t.date "birthday"
    end
  end
end
