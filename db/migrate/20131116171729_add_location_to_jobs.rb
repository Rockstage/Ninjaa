class AddLocationToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :long__c, :string
    add_column :jobs, :lat__c, :string
  end
end
