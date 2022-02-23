require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @list = lists(:first)
  end

  # validations

  test 'validate if list is provided' do
    task = Task.new(list: @list)
    task.valid?
    assert task.errors[:list].empty?
  end

  test 'validate if description is provided' do
    task = Task.new(description: "Need to take the garbage out")
    task.valid?
    assert task.errors[:description].empty?
  end

  test 'invalid if description is not provided' do
    task = Task.new
    task.valid?
    assert_not task.errors[:description].empty?
  end

  test 'invalid if list is not provided' do
    task = Task.new
    task.valid?
    assert_not task.errors[:list].empty?
  end

  # object creation

  test 'can create a Task given there is a List' do
    task = Task.create!(list: @list, description: "Take the dog out")
    task.valid?
    assert_equal Task.all.size, 2
  end

  # instance methods

  test '#initialize_position to 0 if the list is empty' do
    Task.destroy_all
    task = Task.new(list: @list, description: "Take the dog out")
    task.save
    assert_equal task.position, 0
  end

  test 'should have statuses: incomplete and complete' do
    assert Task.statuses.keys.any? {|x| ["incomplete", "complete"].include?(x)}
  end

  test 'should have default value of incomplete for status' do
    task = Task.create!(list: @list, description: 'Take the dog out')
    assert_equal task.status, "incomplete"
  end
end
