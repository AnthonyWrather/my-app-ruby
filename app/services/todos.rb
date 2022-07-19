require 'google/cloud/firestore'
class Todos
  attr_accessor :all

  @userId = ''

  def initialize(current_user)
    @firestore = Google::Cloud::Firestore.new project_id: Rails.application.credentials.google.project_id,
                                              keyfile: Rails.application.credentials.google.keyfile

    @userId = current_user.nil? ? '' : current_user
    get_todos
  end

  def get_todos
    self.all = []

    todos_ref = @firestore.col('todos').where('userId', '=', @userId).order(:createdAt, 'desc')
    todos_ref.get do |todo_ref|
      all << Todo.new(todo_ref.data)
    end
  end
end
