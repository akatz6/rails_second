class Idea < ActiveRecord::Base
	validates :comment,  presence: true, length: { in: 2..30 }
end
