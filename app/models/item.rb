class Item < ApplicationRecord
		has_and_belongs_to_many :carts, dependent: :destroy
	has_attached_file :avatar, styles: {medium: "200x200>", thumb: "150x150>"}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end