class UnauthedUsersSerializer < ActiveModel::Serializer
    attributes :id,
             :username,
             :avatar,
             :created_at,
             :followers_count,
             :following_count,
             :chirp_count
end
