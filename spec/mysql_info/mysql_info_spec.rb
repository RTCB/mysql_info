require 'spec_helper'

module MysqlInfo
  describe MysqlInfo do
    describe "#parse_config" do
      it "should return a Hash" do
        File.should_receive(:open).and_return("key:value")
        YAML.should_receive(:load).and_return({:key => "value"})
        MysqlInfo.parse_config.class.should == Hash
      end
    end
    describe "#all_privileges?" do
      it "should return true if passed username has all privileges"
    end
    describe "#users" do
      it "should return usernames with any privileges on server"
    end
  end
end
