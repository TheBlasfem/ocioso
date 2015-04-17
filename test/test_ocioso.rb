require File.expand_path("../lib/ocioso", File.dirname(__FILE__))

scope do
  class User
    include Ocioso
  end

  test "instance variables" do
    user = User.new name: "Julio", email: "ljuliom@gmail.com"
    assert_equal user.instance_variable_get("@name"), "Julio"
    assert_equal user.instance_variable_get("@email"), "ljuliom@gmail.com"
  end
end