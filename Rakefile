require "rubygems"
require "bundler/setup"

require "coffee-script"

ROOT = File.dirname(__FILE__)
BUILD = "#{ROOT}/build"

namespace :coffee do
  task :clean do
    FileUtils.rm_rf BUILD
    FileUtils.mkdir BUILD
  end

  desc "Build .coffee files into nice JavaScript"
  task :build => :clean do
    Dir.new(ROOT).entries.grep(/coffee/).each do |script|
      puts "Compiling #{script}"

      File.open "#{BUILD}/#{script.gsub(/coffee/, 'js')}", "w+" do |file|
        file.write CoffeeScript.compile File.read("#{ROOT}/#{script}")
      end
    end
  end

end

task :default => 'coffee:build'
