class CreateContactsOffices < ActiveRecord::Migration[5.2]
  def change
    create_join_table :contacts, :offices
  end
end
