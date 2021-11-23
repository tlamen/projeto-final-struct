class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :authentication_token, :is_admin, :profile_picture_url

  has_many :favorites

  def profile_picture_url
    if object.profile_picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true)
    elsif object.is_admin
      object.profile_picture.attach(io: File.open('./imgs/user/autofill/adm.jpg'), filename: 'adm.jpg')
      Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true)
    else
      object.profile_picture.attach(io: File.open("./imgs/user/autofill/#{(object.id)%5}.png"), filename: "#{(object.id)%5}.png")
      Rails.application.routes.url_helpers.rails_blob_path(object.profile_picture, only_path: true)
    end
  end
end
