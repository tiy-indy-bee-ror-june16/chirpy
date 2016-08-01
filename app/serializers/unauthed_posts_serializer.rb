class UnauthedPostsSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
  has_one :user, serializer: UnauthedUsersSerializer

  has_one :photo

  def photo
    Refile.attachment_url(object, :photo)
  end
end
