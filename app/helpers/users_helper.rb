module UsersHelper

  def sex(user)
    user.female == 0 ? t("users.info.woman") : t("users.info.man")
  end
end
