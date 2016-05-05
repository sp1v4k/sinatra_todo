require "todo_list"
require "task"
require "storage"


describe TodoList do
  let(:my_list) { TodoList.new("Toni") }
  let(:content_1) { "make an apple pie" }
  let(:content_2) { "walk the dog" }
  let(:content_3) { "shopping in caprabo" }

  # IMPORTANT in order to isolate test it is needed to reset current_id to 1
  after do
    Task.class_eval('@@current_id = 1')
  end

  describe ".add_task" do
    context "add a new task to our TODO list" do
      it "returns new task content" do
        task1 = Task.new(content_1)
        my_list.add_task(task1)
        task2 = Task.new(content_2)
        my_list.add_task(task2)
        expect(my_list.tasks[0]).to eql(task1)
        expect(my_list.tasks[1]).to eql(task2)
      end
    end
  end

  describe ".delete_task" do
    context "deletes a task given its ID" do
      it "returns the next task of my_list after delete task with ID = 1" do
        task1 = Task.new(content_1)
        my_list.add_task(task1)
        task2 = Task.new(content_2)
        my_list.add_task(task2)
        my_list.delete_task(1)
        expect(my_list.tasks[0]).to eql(task2)
      end
    end
  end

  describe ".find_task_by_id" do
    context "finds a task given its ID" do
      it "returns the task already created with ID = 2" do
        task1 = Task.new(content_1)
        my_list.add_task(task1)
        task2 = Task.new(content_2)
        my_list.add_task(task2)
        expect(my_list.find_task_by_id(2)).to eql(task2)
      end
    end
  end

  describe ".sort_by_created" do
    context "sort tasks by time of creation" do
      before do
        @task1 = Task.new(content_1)
        my_list.add_task(@task1)
        sleep(1)
        @task2 = Task.new(content_2)
        my_list.add_task(@task2)
      end

      it "returns the first task created in @task[0] position" do
        sorted_list = my_list.sort_by_created("ASC")
        expect(sorted_list[0]).to eql(@task1)
      end
      it "returns the last task created in @task[0] position" do
        sorted_list = my_list.sort_by_created("DESC")
        expect(sorted_list[0]).to eql(@task2)
      end
    end
  end

  describe ".new" do
    context "checks user is created and associated to a ToDo list" do
      it "checks if user attribute Toni is in my_list instance" do
        expect(my_list.user).to eql("Toni")
      end
    end
  end

  describe ".save" do
    context "checks taks from a ToDo list has been saved to a file 'tasks.yml'"
    before do
      @my_other_list = TodoList.new("Jorge")
      @task1 = Task.new(content_1)
      @task2 = Task.new(content_2)
      @task3 = Task.new(content_3)
      @my_other_list.add_task(@task1)
      @my_other_list.add_task(@task2)
      @my_other_list.add_task(@task3)
      @my_other_list.save
    end
    it "loads Jorge's tasks from tasks.yml and compare task1 content with saved task1 content" do
      my_other_list = TodoList.new("Jorge")
      my_other_list.load_tasks
      expect(my_other_list.tasks[0].content).to eql(@task1.content)
    end
  end
end
