require_relative 'train'

class CargoTrain < Train
	protected

	def type
		'cargo'
	end
end