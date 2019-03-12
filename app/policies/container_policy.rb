class ContainerPolicy < ApplicationPolicy

    def show_button_restart?
        return true if @user.role != 'guest'
    end

    def show_button_stop?
        return true if @user.role == 'owner'
    end
end