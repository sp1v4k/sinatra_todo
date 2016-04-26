require "task"

describe Task do
  let(:task1) { Task.new("Buy paper towels") }
  let(:task2) { Task.new("Buy milk") }

  after do
    Task.class_eval('@@current_id = 1')
  end


  describe ".new" do
    context "initialization taks's content" do
      it "returns the content" do
        expect(task1.content).to eql("Buy paper towels")
      end
    end
    context "initialization of task id" do
      it "check id is incremental" do
        expect(task1.id).to eql(1)
        expect(task2.id).to eql(2)
      end
    end
  end
  describe ".complete?" do
    context "check task is completed" do
      it "check @complete instance attribute" do
        expect(task2.complete?).to eql(false)
      end
    end
  end

  describe ".complete!" do
    context "changes task to completed status" do
      it "checks @complete is true" do
        task1.complete!
        expect(task1.complete?).to eql(true)
      end
    end
  end

  describe ".make_incomplete!" do
    context "changes task status to incomplete" do
      it "checks @complete is false" do
        task1.make_incomplete!
        expect(task1.complete?).to eql(false)
      end
    end
  end

  describe ".update_content!" do
    context "updates the @content attribute with new/modified task" do
      it "checks @content modification" do
        task1.update_content!("modified task")
        expect(task1.content).to eql("modified task")
      end
    end
  end
end
