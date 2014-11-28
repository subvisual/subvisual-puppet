#!/usr/bin/env ruby
require 'fileutils'

repo = ARGV[0]
user = ARGV[1]

keys_file = "/home/#{user}/.ssh/authorized_keys"

def keys_hash_from_files(files)
  pub_keys = files.map { |f| File.open(f).each_line.to_a }.flatten
  pub_keys.inject({}) do |hash, key|
    email = key.split(/\s+/).last
    if hash[email]
      raise "Duplicate e-mail in public-keys: #{email}"
    else
      hash[email] = key
    end
    hash
  end
end

new_keys = keys_hash_from_files(Dir["#{repo}/*.pub"])
old_keys = keys_hash_from_files(Dir[keys_file])
merged_keys = old_keys.merge(new_keys).values

if File.exists?(keys_file)
  FileUtils.copy_file(keys_file, "#{keys_file}.bak")
end

file = File.open(keys_file, 'w')
file.write(merged_keys.join)
file.close
