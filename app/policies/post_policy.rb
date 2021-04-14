class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      unless user.nil?
        if user.admin?
          scope.all
        else
          scope.where(published: true)
        end
      end
    end
  end

  def destroy?
    user.admin? # or !post.published?
  end

  def update?
    user.present? or !post.published?
  end

  def edit?
    user.present? or !post.published?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end
end
