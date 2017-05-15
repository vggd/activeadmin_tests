ActiveAdmin.register User, :as => "Customer" do

  menu :priority => 4
  permit_params :username, :email, :created_at, :updated_at

  config.batch_actions = true

  filter :username
  filter :email
  filter :created_at

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :created_at
    actions
  end

  show :title => :username do
    panel "Order History" do
      table_for(customer.orders) do
        column("Commande", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
        column("État")                       {|order| status_tag(order.state) }
        column("Date de création", :sortable => :checked_out_at){|order| pretty_format(order.checked_out_at) }
        column("Total")                      {|order| number_to_currency order.total_price }
      end
    end
  end

  sidebar "Customer Details", :only => :show do
    attributes_table_for customer, :username, :email, :created_at
  end

  sidebar "Order History", :only => :show do
    attributes_table_for customer do
      row("Total Orders") { customer.orders.complete.count }
      row("Total Value") { number_to_currency customer.orders.complete.sum(:total_price) }
    end
  end

end
