module ApplicationHelper
	# set active link class for menu
	def active_menu_link(path)
		"#{'menu-active' if request.path.end_with?(path)}"
	end
end
