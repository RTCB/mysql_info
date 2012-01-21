# add current dir to load path
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'mysql_info/mysql_info.rb'
require 'mysql_info/web_interface.rb'
