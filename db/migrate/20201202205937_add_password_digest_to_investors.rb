class AddPasswordDigestToInvestors < ActiveRecord::Migration[6.0]
  def change
    add_column :investors, :password_digest, :string
  end
end
