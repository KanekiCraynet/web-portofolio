# Policy for Message authorization
class MessagePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    true  # Anyone can send a message
  end

  def destroy?
    admin?
  end

  def mark_as_read?
    admin?
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
