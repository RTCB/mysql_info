# add current dir to load path
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require_relative 'mysql_info/mysql_info.rb'
require_relative 'mysql_info/web_interface.rb'
