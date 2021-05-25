# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  piece_id   :integer
#  user_id    :integer
#
class Rating < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:piece, { :required => false, :class_name => "Piece", :foreign_key => "piece_id", :counter_cache => true })
end
