# == Schema Information
#
# Table name: arrangers
#
#  id           :integer          not null, primary key
#  name         :string
#  pieces_count :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Arranger < ApplicationRecord
  has_many(:pieces, { :class_name => "Piece", :foreign_key => "arranger_id", :dependent => :nullify })
end
