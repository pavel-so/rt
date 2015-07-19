class Trap < ActiveRecord::Base
  has_many :entries
  validates :name, length: { in: 1..255 }
end
