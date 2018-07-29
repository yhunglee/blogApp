class Article < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :content

    has_many :comments, -> { order("id DESC")}, :dependent => :destroy
end
