require 'csv'
require 'json'
require 'optparse'

options = {}

opt = OptionParser.new
opt.on('-s', '--start_token_id ARG', 'start_token_id') { |v| options['start_token_id'] = v.to_i || 0 }
opt.on('-e', '--end_token_id ARG', 'end_token_id') { |v| options['end_token_id'] = v.to_i || 0 }
opt.on('-n', '--name ARG', 'name') { |v| options['name'] = v.to_s || '' }
opt.on('-d', '--description ARG', 'description') { |v| options['description'] = v.to_s || '' }
opt.on('-i', '--image_url ARG', 'image_url') { |v| options['image_url'] = v.to_s || '' }
opt.on('-t', '--animation_url ARG', 'animation_url') { |v| options['animation_url'] = v.to_s || '' }
opt.parse(ARGV)

count = (options['end_token_id'] - options['start_token_id'])
token_ids = [*options['start_token_id']..options['end_token_id']]
count.times do |i|
  token_id = token_ids[i + 1]
  File.open(token_id.to_s, 'w') { |f|
    json = {
      "tokenId": token_id,
      "name": "orange ##{token_id}",
      "description": options['description'].to_s,
      "image_url": "ipfs://QmZTYytxwCrqnYaFVasJZYtu5dPiPFxQBjGwiWuAtYpntb/#{token_id - 1}.png",
      "animation_url": options['animation_url'].to_s,
      "attributes": {
        "color": 'orange'
      }
    }
    f.puts JSON.pretty_generate(json)
  }
end
