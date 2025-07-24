class ProductPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

#   def summary?
#     Rails.logger.debug "shyammmmmmmm_product#{user.inspect}"
#     user.present? 
#   end

  def create?
    user.present? && user.admin?
  end

  def update?
    user.present? && user.admin?
  end

  def edit?
    user.present? && user.admin?
  end

  def show?
    user.present? && (user.admin? || user.member?)
  end

  def index?
    user.present? && (user.admin? || user.member?)
  end
end
