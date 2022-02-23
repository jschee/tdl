class List < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates_associated :tasks

  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  after_update_commit { broadcast_replace_to 'lists' }
  after_destroy_commit { broadcast_remove_to 'lists' }
end
