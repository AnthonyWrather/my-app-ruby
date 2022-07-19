require 'google/cloud/firestore'

class MyFolders
  attr_accessor :all

  @userId = ''

  def initialize(current_user)
    @firestore = Google::Cloud::Firestore.new project_id: Rails.application.credentials.google.project_id,
                                              keyfile: Rails.application.credentials.google.keyfile

    @userId = current_user.nil? ? '' : current_user
    get_folders
  end

  def get_folders
    self.all = []

    # folders_ref = @firestore.col('folders').where('userId', '=', @userId).order(:createdAt, 'desc')
    folders_ref = @firestore.col('folders').where('userId', '=', @userId)
    folders_ref.get do |folder_ref|
      puts folder_ref
      all << MyFolder.new(folder_ref.data)
    end
  end
end
