require "yaml"
require "yaml/store"

module Storage
  def todo_store
    @todo_store ||= YAML::Store.new("./public/tasks.yml")
  end

  def save
    todo_store.transaction do
      todo_store[@user] = @tasks
    end
  end

  def load_tasks
    @tasks = todo_store.transaction { @todo_store[@user] }
  end
end
