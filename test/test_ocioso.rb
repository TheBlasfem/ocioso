require File.expand_path("../lib/ocioso", File.dirname(__FILE__))

scope do
  class User
    attr_reader :name, :email
    include Ocioso
  end

  test "" do
    user = User.new name: "Julio", email: "ljuliom@gmail.com"
    assert_equal user.name, "Julio"
    assert_equal user.email, "ljuliom@gmail.com"
  end
end