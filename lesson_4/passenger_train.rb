require_relative 'train'

class PassengerTrain < Train
	protected

	def type
		'passenger'
	end
end