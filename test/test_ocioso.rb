require File.expand_path("../lib/ocioso", File.dirname(__FILE__))

scope do
  class User
    include Ocioso
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
    u = Class.new(User) do
      attr_accessor :name, :email
    end
    u_instance = u.new do |user|
      user.name = "Claudia"
      user.email = "clau@email.com"
    end
    assert_equal u_instance.name, "Claudia"
    assert_equal u_instance.email, "clau@email.com"
  end

  test "init mix, sending hash and block" do
    u = Class.new(User) do
      attr_accessor :name, :email
    end
    u_instance = u.new name: "Piero" do |user|
      user.email = "piero@email.com"
    end
    assert_equal u_instance.name, "Piero"
    assert_equal u_instance.email, "piero@email.com"
  end
end