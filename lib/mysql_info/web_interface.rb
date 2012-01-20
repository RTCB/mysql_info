require 'sinatra/base'
require 'mysql2'
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
    client = Mysql2::Client.new(
      :host => 'mg.uncb.iitp.ru',
      :username => params[:username],
      :password => params[:password],
      :database => 'information_schema'
    )

    query = client.query(
           "select TABLE_SCHEMA,TABLE_NAME,DATA_LENGTH,INDEX_LENGTH
            from TABLES WHERE TABLE_SCHEMA!='information_schema'").each.to_a

    @name_size = query.inject(Hash.new(0)) do |h, n|
      h[n['TABLE_SCHEMA']] += n['DATA_LENGTH'] if n['DATA_LENGTH']
      h
    end

    haml :sizes
  end

end
end
