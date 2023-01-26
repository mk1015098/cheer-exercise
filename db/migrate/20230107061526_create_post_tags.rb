class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :post, null: false
      t.integer :tag, null: false
      t.timestamps
    end
    # 同じタグを２回保存できないようにする
    add_index :post_tags, [:post_id, :tag_id], unique: true
  end
end
