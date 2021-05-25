# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  favorites_count :integer
#  password_digest :string
#  ratings_count   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
  has_many(:ratings, { :class_name => "Rating", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:favorites, { :class_name => "Favorite", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:comments, { :class_name => "Comment", :foreign_key => "user_id", :dependent => :destroy })
end
