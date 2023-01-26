class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :post, type: :integer, foreign_key: true
      t.references :tag,type: :integer, foreign_key: true
      t.timestamps
    end
    # 同じタグを２回保存できないようにする
    add_index :post_tags, [:post_id, :tag_id], unique: true
  end
end
