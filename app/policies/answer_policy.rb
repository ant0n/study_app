class AnswerPolicy < ApplicationPolicy
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

  def set_best?
    user == record.question.author
  end
end
