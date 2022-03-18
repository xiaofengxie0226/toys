class ToysTags < ApplicationRecord

    self.table_name = 'toys_tags'

    validates_uniqueness_of :toy_id, scope: [:tag_id] 
 
    belongs_to :toy
    belongs_to :tag
end
