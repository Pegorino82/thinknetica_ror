require_relative 'train'

class CargoTrain < Train
	protected

	def train_type
		'cargo'
	end
end