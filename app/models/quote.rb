class Quote < ApplicationRecord
  validates :name, presence: true

  belongs_to :company
  has_many :line_item_dates, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }

  # # partialとlocalsはデフォルト値がモデルから推測できるので、省略可
  # # after_create_commit -> { broadcast_prepend_to 'quotes', partial: 'quotes/quote', locals: { quote: self } }
  # after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  # after_update_commit -> { broadcast_replace_later_to 'quotes' }
  # # broadcast_remove_later_to はデータが削除されると取得してジョブを実行できないのでそのメソッドはない
  # after_destroy_commit -> { broadcast_remove_to 'quotes' }

  # after_create_commit after_update_commit after_destroy_commit は以下に纏められる
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
end
