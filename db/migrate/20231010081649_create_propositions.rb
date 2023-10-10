class CreatePropositions < ActiveRecord::Migration[7.0]
  def change
    create_table :propositions do |t|
      t.references :prospect_form, null: false, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
