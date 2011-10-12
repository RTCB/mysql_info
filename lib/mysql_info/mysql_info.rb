require 'active_record'

module MysqlInfo
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
  #   adapter  : mysql
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
      ActiveRecord::Base.establish_connection(
        YAML::load(
          File.open(
            Common::PROJECT_DIR + 'database.yml'
          )
        )
      )
  end

end
