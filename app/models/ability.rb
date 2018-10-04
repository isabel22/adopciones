# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :admin
      give_admin_permissions
    elsif user.has_role? :volunteer
      give_volunteer_permissions
    elsif user.has_role? :requester
      give_requester_permissions(user)
    end
  end

  private

  def give_admin_permissions
    can :manage, Animal
    can :manage, AnimalBreed
    can :manage, AnimalSpecy
    can :manage, User
    can :manage, Request
  end

  def give_volunteer_permissions
    can %i[read approve], Request
    can %i[read write], Animal
    can %i[read write], AnimalBreed
    can %i[read write], AnimalSpecy
  end

  def give_requester_permissions(user)
    can :write, Request
    can :read, Request, id: Request.where(email: user.email).pluck(:id)
  end
end
