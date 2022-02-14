class Todo
  attr_accessor :title, :author

  def initialize(todo = {})
    @firestore = Google::Cloud::Firestore.new project_id: 'fir-on-rails-96b79',
                                              keyfile: Rails.application.credentials.keyfile

    self.title = todo[:title] unless todo.nil?
    self.author = todo[:author] unless todo.nil?
  end

  def save(_title, current_user)
    @firestore.collection('todos').add({
                                         title: _title,
                                         author: current_user[:data]['email']
                                       })
    self.title = _title
    self.author = current_user[:data]['email']
  end
end
