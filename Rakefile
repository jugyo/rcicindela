require 'spec/rake/spectask'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'

name = 'rcicindela'
version = '0.3.2'

spec = Gem::Specification.new do |s|
  s.name = name
  s.version = version
  s.summary = "RCicindela is a wrapper library for Cicindela."
  s.description = <<-EOS
RCicindela is a wrapper library for Cicindela.
Cicindela is a recommendation engine made by Livedoor.
See Also: http://code.google.com/p/cicindela2/
  EOS
  s.files = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb'] + %w(README.rdoc History.txt Rakefile)
  s.author = 'jugyo'
  s.email = 'jugyo.org@gmail.com'
  s.homepage = 'http://github.com/jugyo/rcicindela'
  s.rubyforge_project = 'rcicindela'
  s.has_rdoc = false
end

Rake::GemPackageTask.new(spec) do |p|
  p.need_tar = true
end

task :install => [ :package ] do
  sh %{sudo gem install pkg/#{name}-#{version}.gem}
end

task :uninstall => [ :clean ] do
  sh %{sudo gem uninstall #{name}}
end

desc 'run all specs'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
end

Rake::RDocTask.new do |t|
  t.rdoc_dir = 'rdoc'
  t.title    = "rest-client, fetch RESTful resources effortlessly"
  t.options << '--line-numbers' << '--inline-source' << '-A cattr_accessor=object'
  t.options << '--charset' << 'utf-8'
  t.rdoc_files.include('README.rdoc')
  t.rdoc_files.include('lib/rcicindela.rb')
end

CLEAN.include [ 'pkg', '*.gem' ]
