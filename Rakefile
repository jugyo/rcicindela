# -*- coding: utf-8 -*-
$:.unshift File.dirname(__FILE__) + '/lib/'
require 'rcicindela'
require 'spec/rake/spectask'

desc 'run all specs'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['-c']
end

desc 'Generate gemspec'
task :gemspec do |t|
  open('rcicindela.gemspec', "wb" ) do |file|
    file << <<-EOS
Gem::Specification.new do |s|
  s.name = 'rcicindela'
  s.version = '#{RCicindela::VERSION}'
  s.summary = "RCicindela is a wrapper library for Cicindela."
  s.description = "RCicindela is a wrapper library for Cicindela.\\n" +
    "Cicindela is a recommendation engine made by Livedoor.\\n" +
    "See Also: http://code.google.com/p/cicindela2/"
  s.files = %w( #{Dir['lib/**/*.rb'].join(' ')}
                #{Dir['spec/**/*.rb'].join(' ')}
                README.rdoc
                History.txt
                Rakefile )
  s.author = 'jugyo'
  s.email = 'jugyo.org@gmail.com'
  s.homepage = 'http://github.com/jugyo/rcicindela'
  s.rubyforge_project = 'rcicindela'
end
    EOS
  end
  puts "Generate gemspec"
end

desc 'Generate gem'
task :gem => :gemspec do |t|
  system 'gem', 'build', 'rcicindela.gemspec'
end
