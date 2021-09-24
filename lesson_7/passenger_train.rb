require_relative 'train'

class PassengerTrain < Train
	attr_reader :type

	def type
		'passenger'
	end
end
