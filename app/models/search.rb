class Search < ActiveRecord::Base
	def microposts
		@microposts ||= find_microposts
	end
	
	def find_microposts
		Micropost.find(:all, :conditions => conditions)
	end
	
	def start_town_conditions
		["start_town LIKE ?", "%#{start_town}%"] unless start_town.blank?
	end
	
	def drop_town_conditions
		["drop_town LIKE ?", "%#{drop_town}%"] unless drop_town.blank?
	end
	
	def conditions
		[conditions_clauses.join(' AND '), *conditions_options]
	end
	
	def conditions_clauses
		conditions_parts.map { |condition| condition.first} 
	end
	
	def conditions_options
		conditions_parts.map { |condition| condition[1..-1] }.flatten 
	end
	
	def conditions_parts
		methods.grep(/_conditions$/).map{ |m| send(m)}.compact
	end
end
