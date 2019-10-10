module PostHelper
    def current_user_initial
        current_user.first_name[0].upcase
    end
end