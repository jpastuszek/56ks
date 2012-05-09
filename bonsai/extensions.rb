module Bonsai
	class Exporter
		class << self
			def write_pages
				Bonsai.log "Writing pages"
				Page.all.select{|page| page.permalink != '/index/'}.each do |page|
					Bonsai.log "\t Writing page - #{page.permalink}"
					FileUtils.mkdir_p("#{path}#{page.permalink}")
					File.open("#{path}#{page.write_path}", "w"){|file| file.write(page.render) }
				end
			end
		end
	end

	class Page
		def relative_root
			return '' if permalink == '/index/'
			permalink.split('/').select{|a| not a.empty?}.map{|a| '..'}.join('/') + '/'
		end

		alias :orig_to_hash :to_hash
		def to_hash
			h = orig_to_hash.merge('relative_root' => relative_root)
			p permalink
			if permalink == '/index/'
				h['permalink'] = '/'
				h['slug'] = ''
			end
			p h
		end
	end
end

