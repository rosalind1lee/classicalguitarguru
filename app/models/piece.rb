# == Schema Information
#
# Table name: pieces
#
#  id              :integer          not null, primary key
#  comments_count  :integer          default(0)
#  favorites_count :integer          default(0)
#  ratings_count   :integer          default(0)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  arranger_id     :integer
#  composer_id     :integer
#
class Piece < ApplicationRecord
  belongs_to(:composer, { :required => false, :class_name => "Composer", :foreign_key => "composer_id", :counter_cache => true })
  has_many(:ratings, { :class_name => "Rating", :foreign_key => "piece_id", :dependent => :destroy })
  has_many(:favorites, { :class_name => "Favorite", :foreign_key => "piece_id", :dependent => :nullify })
  has_many(:comments, { :class_name => "Comment", :foreign_key => "piece_id", :dependent => :destroy })
  belongs_to(:arranger, { :required => false, :class_name => "Arranger", :foreign_key => "arranger_id", :counter_cache => true })
end
