require "sinatra"
require "sinatra/reloader"
require_relative "lib/task.rb"
require_relative "lib/todo_list.rb"

todo_list = TodoList.new("Toni")
todo_list.load_tasks

get "/tasks" do
  @todo_list = todo_list
  erb :task_index
end

get "/new_task" do
  erb :new_task
end

post "/create_task" do
  content = params.fetch("content", 0)
  task = Task.new(content)
  todo_list.add_task(task)
  redirect to("/tasks")
end

get "/complete_task/:id" do
  id = params["id"]
  todo_list.find_task_by_id(id).complete!
  todo_list.save
  redirect to("/tasks")
end
