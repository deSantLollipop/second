class PostPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if !user.nil?
        if user.admin?
         scope.all
        else
         scope.where(published: true)
        end
      end
    end
  end

  def update?
    user.admin? or not post.published?
  end

  def edit?
    user.admin? or not post.published?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

end