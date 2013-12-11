module ApplicationHelper

	def full_title(page_title)
		base_title = "Go Bazinga everytime you fall"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	
end
