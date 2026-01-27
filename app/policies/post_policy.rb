# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:post_type).where(post_types: {user_id: user.id})
    end
  end

  def create?
    user.present?
  end

  def show?
    owner_or_admin?
  end

  def edit?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    record.post_type.user_id == user&.id || user&.admin?
  end
end
