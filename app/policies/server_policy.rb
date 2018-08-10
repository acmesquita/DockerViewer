class ServerPolicy < ApplicationPolicy

    def show_buttons?
        return true if @user.role == 'owner'
    end

    def create_server?
        return true if @user.role == 'owner'
    end
end