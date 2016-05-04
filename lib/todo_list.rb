require "yaml"
require "yaml/store"

class TodoList
  attr_reader :tasks, :user
  def initialize(user)
    @todo_store = YAML::Store.new("./public/tasks.yml")
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

  # def save
  #   @todo_store.transaction do
  #     @todo_store[@user] = @tasks
  #   end
  # end
  #
  # def load_tasks(user)
  #   @tasks = @todo_store.transaction do
  #     @todo_store[user]
  #   end
  # end
end
