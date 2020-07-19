class AddUsers < ActiveRecord::Migration[6.0]
  def change
    User.create(name: "Ali Shah")
  end
end
