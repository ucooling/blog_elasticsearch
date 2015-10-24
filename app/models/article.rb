class Article < ActiveRecord::Base
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	def self.search(query)
		__elasticsearch__.search(
				{
						query: {
								multi_match: {
										query: query,
										fields: ['title^10', 'text']
								}
						}
				}
		)
	end

	settings index: { number_of_shards: 1 } do
		mappings dynamic: 'false' do
			indexes :title, analyzer: 'english'
			indexes :text, analyzer: 'english'
		end
	end

end
