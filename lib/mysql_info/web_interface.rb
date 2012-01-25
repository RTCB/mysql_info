require 'rubygems'
require 'sinatra/base'
require 'active_record'
require 'haml'

module MysqlInfo
class WebInterface < Sinatra::Base

  set :sass,
      :views => File.expand_path(File.join(Dir.pwd, '..', 'views', 'style'))
  set :haml,
      :views => File.expand_path(File.join(Dir.pwd, '..', 'views'))

  get '/css/style.css' do
    sass :sizes
  end

  get '/' do
    haml :login
  end

  post '/' do
    ActiveRecord::Base.establish_connection(
      :adapter => 'mysql',
      :host => 'mg.uncb.iitp.ru',
      :username => params[:username],
      :password => params[:password],
      :database => 'information_schema'
    )

    query = ActiveRecord::Base.connection.execute(
           "select TABLE_SCHEMA,DATA_LENGTH
            from TABLES WHERE TABLE_SCHEMA!='information_schema'")

    @name_size = Hash.new(0)
    query.each{|r| @name_size[r.first] += r.last.to_i if r.last }
    @name_size = @name_size.sort{|a,b| a.last<=>b.last}.reverse

    haml :sizes
  end

end
end
