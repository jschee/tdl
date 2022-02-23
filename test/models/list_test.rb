require 'test_helper'

class ListTest < ActiveSupport::TestCase
  test 'should create a List' do
    List.create!(name: 'My new list')
    assert_equal List.all.size, 2
  end

  test 'validate if name is provided' do
    todo = List.new(name: 'crap')
    todo.valid?
    assert_empty todo.errors[:name]
  end

  test 'invalid if name is not provided' do
    todo = List.new
    todo.valid?
    assert_not todo.errors[:name].empty?
  end
end
