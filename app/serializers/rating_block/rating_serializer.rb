class RatingBlock::RatingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :value

  attribute :user_data do |object|
    UserBlock::UserSerializer.new(object.user)
  end

end
