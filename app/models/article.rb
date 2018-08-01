class Article < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :content

    has_many :comments, -> { order("id DESC")}, :dependent => :destroy
    belongs_to :user, :foreign_key => 'author_id'
end
