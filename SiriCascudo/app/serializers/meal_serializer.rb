class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :category_id, :picture_url

  def picture_url
    if object.picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.picture)
    else
      false
    end
  end
end
