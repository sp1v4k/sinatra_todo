require "yaml"
require "yaml/store"

module Storage
  @todo_store = YAML::Store.new("./public/tasks.yml")

  def save(user, tasks)
    @todo_store.transaction do
      @todo_store[user] = tasks
    end
  end

  def load_tasks(user)
    @todo_store.transaction { @todo_store[user] }
  end
end
