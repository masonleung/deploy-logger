class CreateDeployTable < ActiveRecord::Migration
  def change
    create_table :deploy_logs do |t|
        t.string :deployer
        t.string :tag
        t.string :application
        t.timestamps
        t.string :environment
    end
  end
end
