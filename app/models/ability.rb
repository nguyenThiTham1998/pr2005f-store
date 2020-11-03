class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # nếu chưa login
        if user.admin?
            can :manage, :all # cấp tất cả quyền cho admin
            can :manage, :admin_all
        else
            can :manage, :all # cấp quyền cho user không phải là admin
        end
    end
end