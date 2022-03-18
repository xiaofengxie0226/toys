class Tag < ApplicationRecord
    
    validates :title, uniqueness: { message: "Tag already exists" }

    has_many :toys_tags, class_name: "ToysTags"
    has_many :toys, through: :toys_tags
end
