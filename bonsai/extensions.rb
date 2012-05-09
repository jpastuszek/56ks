module Bonsai
	class Page
		def relative_root
			p Page.all
			permalink.split('/').select{|a| not a.empty?}.map{|a| '..'}.join('/') + '/'
		end

		alias :orig_to_hash :to_hash
		def to_hash
			p orig_to_hash.merge('relative_root' => relative_root)
		end
	end
end

