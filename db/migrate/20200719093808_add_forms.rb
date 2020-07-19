class AddForms < ActiveRecord::Migration[6.0]
  def change
    Form.create(name: "1099", is_system_generated: false)
    Form.create(name: "W-2", is_system_generated: false)
    Form.create(name: "1040", is_system_generated: trust)
  end
end
