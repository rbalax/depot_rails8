class CreateSupportRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :support_requests do |t|
      t.timestamps
      t.string :email, comment: "Email of the submitter"
      t.string :subject, comment: "Subject of the support request"
      t.text :message, comment: "Message of the support request"
      t.references :order, null: true, foreign_key: true, comment: "Associated order, if applicable"
    end
  end
end
