class Toy < ApplicationRecord
    validates :toyname, presence: { message: "Toyname is vacancy" }
    #validates :description, presence: { message: "" }
    validates :user_id, presence: { message: "UserID is vacancy" }
    validates :url, presence: { message: "Please input your toy's url" }
    
    belongs_to :user
    has_many :toys_tags,class_name: "ToysTags"
    has_many :tags, through: :toys_tags

    def tags_string= one_tags

        self.tags.destroy_all
        one_tags.split(',').each do |tag|
            one_tag = Tag.find_by(title: tag)
            one_tag = Tag.new(title: tag) unless one_tag

            self.tags << one_tag
        end
    end
end
