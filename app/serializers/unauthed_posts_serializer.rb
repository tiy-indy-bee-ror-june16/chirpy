class UnauthedPostsSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
  has_one :user, serializer: UnauthedUsersSerializer
end
