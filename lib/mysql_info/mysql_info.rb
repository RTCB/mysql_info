require 'active_record'
require 'yaml'
require 'set'

module MysqlInfo
  CONFIG_PATH = "~/database.yaml"

  KEYS = [
    :host,
    :username,
    :password,
    :database
  ]

  PRIVILEGE_TYPES = [
    'SELECT',
    'INSERT',
    'UPDATE',
    'DELETE',
    'CREATE',
    'DROP',
    'REFERENCES',
    'INDEX',
    'ALTER',
    'CREATE TEMPORARY TABLES',
    'LOCK TABLES',
    'EXECUTE',
    'CREATE VIEW',
    'SHOW VIEW',
    'CREATE ROUTINE',
    'ALTER ROUTINE',
    'EVENT',
    'TRIGGER'
  ]

  # Connect to the MySQL database server
  #
  # Method searches for database.yml file in {Common::PROJECT_DIR}.
  # It then uses the credentials from that file to
  # connect to the database server.
  #
  # @example
  #   # database.yml
  #   host     : localhost
  #   username : reader
  #   password : password
  #   database : insectdb4_core
  #
  # @note
  #   This method should be called before any other
  #   method from this module
  #
  # @param [Boolean] local should be set to true when debugging
  def self.connect
      ActiveRecord::Base
        .establish_connection(self.parse_config)
  end

  def self.parse_config
    begin
      f = File.open(MysqlInfo::CONFIG_PATH)
    rescue Errno::ENOENT => e
      puts "Configuration file not found"
      puts e.message
      raise
    rescue Errno::EACCESS => e
      puts "Permission denied for reading configuration file"
      puts e.message
      raise
    end

    begin
      config = YAML.load(f)
    rescue ArgumentError => e
      puts "Wrong format of config file"
      puts e.message
    end

    return {}

  end

end
