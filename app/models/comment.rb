class Comment < ApplicationRecord
    validates_presence_of :content

    belongs_to :article
    belongs_to :user
end
