module ApplicationHelper

	def flash_class(type)
		case type
		when :alet
			"alert-danger"
		when :notice
			"alert-info"
		else
			""
		end
	end

end
