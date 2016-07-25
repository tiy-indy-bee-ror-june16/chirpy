class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :avatar,
             :created_at,
             :followers_count,
             :following_count,
             :chirp_count,
             :currently_being_followed

  def currently_being_followed
    current_user.follows?(object)
  end
end
