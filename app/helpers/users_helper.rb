module UsersHelper

  def sex(user)
    user.female = 1 ? "Woman" : "Man"
  end
end
