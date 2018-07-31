class Comment < ApplicationRecord
    validates_presence_of :content

    belongs_to :article
    belongs_to :user, :foreign_key => 'author_id'
end
