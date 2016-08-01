class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
  has_one :user
  has_one :photo

  def photo
    Refile.attachment_url(object, :photo)
  end
end
