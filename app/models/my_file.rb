class MyFile
  attr_accessor :name, :url, :folderId, :userId, :createdAt

  def initialize(myFile = {})
    # createdAt
    # folderId
    # name
    # url
    # userId

    @firestore = Google::Cloud::Firestore.new project_id: Rails.application.credentials.google.project_id,
                                              keyfile: Rails.application.credentials.google.keyfile

    self.name = myFile[:name] unless myFile[:name].nil?
    self.url = myFile[:url] unless myFile[:url].nil?
    self.folderId = myFile[:folderId] unless myFile[:folderId].nil?
    self.userId = myFile[:userId] unless myFile[:userId].nil?
    self.createdAt = myFile[:createdAt] unless myFile[:createdAt].nil?
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
