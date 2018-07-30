class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :articles, -> { order("updated_at DESC")}, :dependent => :destroy
  has_many :comments, -> { order("updated_at DESC")}, :dependent => :destroy
end
