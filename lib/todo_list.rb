require_relative "storage"

class TodoList
  include Storage
  attr_reader :tasks, :user
  def initialize(user)
    @tasks = []
    @user = user
  end

  def add_task(task)
    @tasks << task
  end

  def delete_task(id)
    index = @tasks.find_index { |task| task.id == id }
    @tasks.delete_at(index)
  end

  def find_task_by_id(id)
    @tasks.bsearch { |task| task.id == id }
  end

  def sort_by_created(sort_mode)
    if sort_mode == "ASC"
      @tasks.sort { |task1, task2| task1.created_at <=> task2.created_at }
    else
      @tasks.sort { |task1, task2| task2.created_at <=> task1.created_at }
    end
  end
end
