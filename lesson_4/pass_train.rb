require_relative 'train'

class PassTrain < Train
	protected

	def train_type
		'passenger'
	end
end