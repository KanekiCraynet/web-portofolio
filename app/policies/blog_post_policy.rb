# Policy for BlogPost authorization
class BlogPostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || owner? || admin?
  end

  def create?
    user&.admin? || user&.editor?
  end

  def update?
    admin? || (editor? && owner?)
  end

  def destroy?
    admin? || (editor? && owner?)
  end

  def publish?
    admin? || (editor? && owner?)
  end

  def unpublish?
    publish?
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      elsif user&.editor?
        scope.where(user: user).or(scope.published)
      else
        scope.published
      end
    end
  end
end
