class UserExpandedSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :email,
             :bio,
             :auth_token,
             :avatar,
             :followers_count,
             :following_count,
             :chirp_count
end
