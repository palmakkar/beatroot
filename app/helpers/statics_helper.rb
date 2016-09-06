module StaticsHelper
	def full_title(name = '')
		base_title = "BeatRoot"
		if name.empty?
			return base_title
		else
			return name + " | " + base_title
		end
	end
end
