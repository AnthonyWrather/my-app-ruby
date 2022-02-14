require 'google/cloud/firestore'
class Todos
  attr_accessor :all

  def initialize
    @firestore = Google::Cloud::Firestore.new project_id: 'fir-on-rails-96b79',
                                              keyfile: Rails.application.credentials.keyfile

    get_todos
  end

  def get_todos
    self.all = []

    todos_ref = @firestore.col('todos').order(:title, :desc)
    todos_ref.get do |todo_ref|
      all << Todo.new(todo_ref.data)
    end
  end
end
