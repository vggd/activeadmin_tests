ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1
  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "10 Dernières Commandes" do
          table_for Order.complete.order('id desc').limit(10) do
            column("État")   {|order| status_tag(order.state)                                    }
            column("Client") {|order| link_to(order.user.email, admin_customer_path(order.user)) }
            column("Total")  {|order| number_to_currency order.total_price                       }
          end
        end
      end

      column do
        panel "10 Derniers Clients" do
          table_for User.order('id desc').limit(10).each do |customer|
            column(:email)                {|customer| link_to(customer.email, admin_customer_path(customer)) }
            column("Date de création")    {|customer| customer.created_at }
          end
        end
      end

    end

    columns do

      column do
        panel "Produits" do
           table_for Product.order('id asc').limit(5).each do
             column("Nom de l'Offre")         {|product| link_to(product.title)           }
             column("Description de l'Offre") {|product| product.description              }
             column("Prix")                   {|product| number_to_currency product.price }
           end
        end
      end

    end

     # columns

    # == Simple Dashboard Column
    # Here is an example of a simple dashboard column
    #
    #   column do
    #     panel "Recent Posts" do
    #       content_tag :ul do
    #         Post.recent(5).collect do |post|
    #           content_tag(:li, link_to(post.title, admin_post_path(post)))
    #         end.join.html_safe
    #       end
    #     end
    #   end

    # == Render Partials
    # The block is rendererd within the context of the view, so you can
    # easily render a partial rather than build content in ruby.
    #
    #   column do
    #     panel "Recent Posts" do
    #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
    #     end
    #   end

  end # content
end
