class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    # The record has to exist AND (the record is public OR the user has a premium or admin account OR the user is a collaborator on that reecord)
    (scope.where(:id => record.id).exists?) && (( record.public? ) || ( user.premium? || user.admin? ) || ( record.users.include?(user) ))
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def scope
    # Pundit.policy_scope!(user, record.class)
    record.class
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

