require 'rubygems'
require 'rake'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")

GENERATED_PARSER = "lib/jabl-rkelly/generated_parser.rb"

file GENERATED_PARSER => "lib/parser.y" do |t|
  if ENV['DEBUG']
    sh "racc -g -v -o #{t.name} #{t.prerequisites.first}"
  else
    sh "racc -o #{t.name} #{t.prerequisites.first}"
  end
end

desc "Generate the parser code."
task :parser => GENERATED_PARSER

# ----- Packaging -----

require 'rake/gempackagetask'
load    'jabl-rkelly.gemspec'

Rake::GemPackageTask.new(JABL_RKELLY_GEMSPEC) do |pkg|
  pkg.need_tar_gz = Rake.application.top_level_tasks.include?('release')
end
Rake::Task[:package].prerequisites << :parser

desc "Install Jabl::RKelly as a gem."
task :install => [:package] do
  sudo = RUBY_PLATFORM =~ /win32/ ? '' : 'sudo'
  sh %{#{sudo} gem install pkg/jabl-rkelly-#{File.read('VERSION').strip}}
end

desc "Release a new Jabl:RKelly package to Rubyforge. Requires the NAME and VERSION flags."
task :release => [:package] do
  name, version = ENV['NAME'], ENV['VERSION']
  raise "Must supply NAME and VERSION for release task." unless name && version
  sh %{rubyforge login}
  sh %{rubyforge add_release jabl-rkelly jabl-rkelly "#{name} (v#{version})" pkg/jabl-rkelly-#{version}.gem}
  sh %{rubyforge add_file    jabl-rkelly jabl-rkelly "#{name} (v#{version})" pkg/jabl-rkelly-#{version}.tar.gz}
end

# ----- Default: Testing ------

task :default => :test

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  test_files = FileList['test/**/test_*.rb']
  t.test_files = test_files
  t.verbose = true
end
Rake::Task[:test].prerequisites << :parser

# ----- Misc -----

desc "Create a new node"
task :new_node do
  filename = ENV['NODE']
  raise "invalid node name" if !filename

  classname = nil
  if filename =~ /[A-Z]/
    classname = filename
    filename = filename.gsub(/([A-Z])/) { |x| "_#{x.downcase}" }.gsub(/^_/, '')
  end

  full_file = "lib/rkelly/nodes/#{filename}.rb"
  test_file = "test/test_#{filename}.rb"
  puts "writing: #{full_file}"
  File.open(full_file, 'wb') { |f|
    f.write <<-END
module RKelly
  module Nodes
    class #{classname} < Node
    end
  end
end
    END
  }
  puts "adding to nodes include"
  File.open("lib/rkelly/nodes.rb", 'ab') { |f|
    f.puts "require 'rkelly/nodes/#{filename}'"
  }

  puts "writing test case: #{test_file}"
  File.open(test_file, 'wb') { |f|
    f.write <<-END
require File.dirname(__FILE__) + "/helper"

class #{classname}Test < NodeTestCase
  def test_failure
    assert false
  end
end
    END
  }
end
