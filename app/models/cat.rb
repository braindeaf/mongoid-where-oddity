class Cat
  include Mongoid::Document

  field :name
  field :lazy, type: Mongoid::Boolean

  default_scope -> { where(lazy: true) }
end
