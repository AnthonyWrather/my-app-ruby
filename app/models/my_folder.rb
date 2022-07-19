class MyFolder
  attr_accessor :name, :parentId, :path, :userId, :createdAt

  def initialize(myFolder = {})
    # name
    # parentId
    # path[]
    # userId
    # createdAt

    @firestore = Google::Cloud::Firestore.new project_id: Rails.application.credentials.google.project_id,
                                              keyfile: Rails.application.credentials.google.keyfile

    puts myFolder
    self.name = myFolder[:name] unless myFolder[:name].nil?
    self.parentId = myFolder[:parentId] unless myFolder[:parentId].nil?
    self.path = myFolder[:path] unless myFolder[:path].nil?
    self.userId = myFolder[:userId] unless myFolder[:userId].nil?
    self.createdAt = myFolder[:createdAt] unless myFolder[:createdAt].nil?
  end

  # def save(_name, current_user)
  #   @firestore.collection('todos').add({
  #                                        title: _name,
  #                                        author: current_user[:data]['email'],
  #                                        userId: current_user[:data]['localId'],
  #                                        createdAt: @firestore.field_server_time
  #                                      })
  #   self.name = _name
  #   self.author = current_user[:data]['email']
  #   self.userId = current_user[:data]['localId']
  #   self.createdAt = current_user[:data]['createdAt']
  #   # puts "============================================="
  #   # puts "Save: " + self.title + " | " + self.author + " | " + self.userId
  # end
end
