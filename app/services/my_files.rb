require 'google/cloud/firestore'

class MyFiles
  attr_accessor :all

  @userId = ''

  def initialize(current_user)
    @firestore = Google::Cloud::Firestore.new project_id: Rails.application.credentials.google.project_id,
                                              keyfile: Rails.application.credentials.google.keyfile

    @userId = current_user.nil? ? '' : current_user
    get_files
  end

  def get_files
    self.all = []

    files_ref = @firestore.col('files').where('userId', '=', @userId).order(:createdAt, 'desc')
    files_ref.get do |file_ref|
      all << MyFile.new(file_ref.data)
    end
  end
end
