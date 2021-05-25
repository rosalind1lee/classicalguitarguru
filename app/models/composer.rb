# == Schema Information
#
# Table name: composers
#
#  id           :integer          not null, primary key
#  era          :string
#  name         :string
#  pieces_count :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Composer < ApplicationRecord
  has_many(:pieces, { :class_name => "Piece", :foreign_key => "composer_id", :dependent => :destroy })
end
