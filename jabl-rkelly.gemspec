JABL_RKELLY_GEMSPEC = Gem::Specification.new do |spec|
  spec.rubyforge_project = spec.name = 'jabl-rkelly'
  spec.summary = "Jabl::RKelly parses the dialect of Javascript used in Jabl."
  spec.version = File.read('VERSION').strip
  spec.authors = ['Nathan Weizenbaum', 'Aaron Patterson']
  spec.email = 'nex342@gmail.com'

  readmes = FileList.new('*') do |list|
    list.exclude(/(^|[^.a-z])[a-z]+/)
  end.to_a
  spec.files = FileList['lib/**/*', 'test/**/*', 'Rakefile'].to_a + readmes
  spec.test_files = FileList['test/**/test_*.rb'].to_a
end
