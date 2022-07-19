class Todo
  attr_accessor :title, :author, :userId, :createdAt

  def initialize(todo = {})
    @firestore = Google::Cloud::Firestore.new project_id: Rails.application.credentials.google.project_id,
                                              keyfile: Rails.application.credentials.google.keyfile

    self.title = todo[:title] unless todo[:title].nil?
    self.author = todo[:author] unless todo[:author].nil?
    self.userId = todo[:userId] unless todo[:userId].nil?
    self.createdAt = todo[:createdAt] unless todo[:userId].nil?
  end

  def save(_title, current_user)
    @firestore.collection('todos').add({
                                         title: _title,
                                         author: current_user[:data]['email'],
                                         userId: current_user[:data]['localId'],
                                         createdAt: @firestore.field_server_time
                                       })
    self.title = _title
    self.author = current_user[:data]['email']
    self.userId = current_user[:data]['localId']
    self.createdAt = current_user[:data]['createdAt']
  end
end
