class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user == record.author
  end

  def destroy?
    user == record.author
  end

  def edit?
    user == record.author
  end
end
