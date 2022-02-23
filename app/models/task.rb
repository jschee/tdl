class Task < ApplicationRecord
  enum status: [:incomplete, :complete]

  belongs_to :list

  validates :description, presence: true
  validates :list, presence: true
  validates :status, inclusion: { in: statuses.keys, message: :invalid }

  # before_save :initialize_position, if: Proc.new { |task| task.list.tasks.empty? }
  before_save :check_for_status_change

  after_destroy_commit do
    broadcast_update_to(list,
                        :tasks,
                        target: 'complete-tasks',
                        partial: 'lists/complete_tasks',
                        locals: { list: list,
                                  tasks: list.tasks.complete })
  end

  after_destroy_commit do
    broadcast_update_to(list,
                        :tasks,
                        target: 'incomplete-tasks',
                        partial: 'lists/incomplete_tasks',
                        locals: { list: list,
                                  tasks: list.tasks.incomplete })
  end

  # def initialize_position
  #   self.position = 0
  # end

  # def transition_status
  #   p "in transition status"
  # end

  private

  # def check_for_status_change
  #   return if new_record?
  #   transition_status if status_changed?
  # end
end
