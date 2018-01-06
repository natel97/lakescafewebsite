ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

 content title: proc{ I18n.t("active_admin.dashboard") } do
  #   div class: "blank_slate_container", id: "dashboard_default_message" do
  #     span class: "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
  #   end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    columns do
      column do
        panel "Soups" do
          section do
            #table_for Soup.all do |s|
            #  s.column("Soup") {|soup| soup.name}
            #  s.column("Available") {|soup| check_box("Available", soup.id, {checked: soup.is_today})}
          #end
          #button("Update")
            form_for :soup, :url => "/admin/set-soup", :html => { :method => :put } do
              table_for Soup.all do |s|
                fields_for "soup[]", s do |soup_fields|
                  s.column("Soup") {|soup| soup.name}
                  s.column("Available") {|soup| "soup", "is_today"}
                end
              end
              submit_tag
            end
          end
        end
      end
      column do
        panel "Welcome" do

        div do
          br
          text_node %{
            <h1>Image URLS</h1>
            <h3>Here are some pre-defined images you can use for ImageURL for sections!</h3>
            <p>/french-dip.jpg</p>
            <p>/half-melt.jpg</p>
            <p>/hot-beef.jpg</p>
            <p>/kid-fish.jpg</p>
            <p>/lakes-burger.jpg</p>
            <p>/number-one-with-cheese.jpg</p>
            <p>/omelet.jpg</p>
            <p>/pancake.jpg</p>
            <p>/philly-melt.jpg</p>
            <p>/plain-chicken.jpg</p>
            <p>/salad.jpg</p>
            <p>/poor-boy.jpg</p>
            <p>/salad-lg.jpg</p>
            <p>/soup.jpg</p>
            <p>/weekly-special.jpg</p>
            <p>If you have any questions, feel free to email me <a href="mailto:nate.lubitz@gmail.com">here</a>.</p>
          }.html_safe
        end
      end
      end
    end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
   # content
 end
end
