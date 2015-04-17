require File.expand_path("../lib/ocioso", File.dirname(__FILE__))

scope do
  class User
    include Ocioso
    attr_accessor :name, :email
  end

  test "init blank" do
    user = User.new
    assert_equal user.is_a?(User), true
    assert_equal user.instance_variable_get("@name"), nil
  end

  test "instance variables" do
    user = User.new name: "Julio", email: "julio@email.com"
    assert_equal user.instance_variable_get("@name"), "Julio"
    assert_equal user.instance_variable_get("@email"), "julio@email.com"
  end

  test "init with block" do
    user = User.new do |user|
      user.name = "Claudia"
      user.email = "clau@email.com"
    end
    assert_equal user.name, "Claudia"
    assert_equal user.email, "clau@email.com"
  end

  test "init mix, sending hash and block" do
    user = User.new name: "Piero" do |user|
      user.email = "piero@email.com"
    end
    assert_equal user.name, "Piero"
    assert_equal user.email, "piero@email.com"
  end

  test "init with defaults" do
    class User
      initialize_defaults name: "Julio"
    end
    user = User.new
    assert_equal user.instance_variable_get("@name"), "Julio"
  end

  test "customizing defaults" do
    class User
      initialize_defaults name: "Julio", email: "julio@gmail.com"
    end
    user = User.new name: "Piero"
    assert_equal user.instance_variable_get("@name"), "Piero"
    assert_equal user.instance_variable_get("@email"), "julio@gmail.com"
  end
end