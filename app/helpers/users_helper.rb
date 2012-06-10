module UsersHelper

  def sex(user)
    user.female = true ? "Woman" : "Man"
  end
end
