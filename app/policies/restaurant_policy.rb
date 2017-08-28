class RestaurantPolicy < ApplicationPolicy

  # def new?
  #   true
  # end

  def create?
    true
  end

  def show?
    true
    # only owner can show
  end

  # def edit?
  #   # if Im the owner of the @restaurant
  #   # => true
  #   # else
  #   # => false

  #   # - user => current_user from Devise
  #   # - record => @restaurant

  #   is_owner?
  # end

  def update?
    is_owner? || is_super_admin?
  end

  def destroy?
    is_owner? || is_admin? || is_super_admin?
  end

  private
  def is_owner?
    record.user == user
  end

  def is_admin?
    user.role == 'admin'
  end

  def is_super_admin?
    user.role == 'super_admin'
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
