desc 'push to origin'
task :push do
  `git push origin dev`
end

desc 'pull from origin'
task :pull do
  `git pull origin dev`
end

task :yard do
  `rm -rf .yardoc && yard server --reload`
end

task :tag do
  `ctags -R --exclude=.git --exclude=log *`
end
