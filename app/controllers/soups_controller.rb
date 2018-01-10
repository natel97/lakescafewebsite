class SoupsController < ApplicationController
  def set_variables
    if request.put?
      params.permit!
      puts params
      keys = params[:key]
      values = params[:value]
      unless keys.nil?
        keys.each do |key|
          var = Variable.find(key)
          var.key = keys[key]
          var.save
        end
      end
      unless values.nil?
        values.each do |value|
          var = Variable.find(value)
          var.value = values[value]
          var.save
        end
      end
      google_drive if params[:google_drive]
      flash[:notice] = 'You have updated variables!'
      redirect_to admin_dashboard_path
    end
  end

  def set_soups
    if request.put?
      params.permit!
      available = params[:soup][:available]
      available.keys.each do |key|
        soup = Soup.find(key.to_i)
        soup.updated_at = DateTime.now
        soup.is_today = available[key].eql?('yes')
        soup.save
      end
      flash[:notice] = 'You have updated the soups for the day!'
      redirect_to admin_dashboard_path
    end
  end

  def google_drive
    if Variable.where(key: 'ACTIVATION_URL').first.nil?
      client = google_drive_part_one
    else
      complete_activation
    end
  end

  def google_drive_part_one
    client_id = Variable.where(key: 'CLIENT_ID').first.value
    client_secret = Variable.where(key: 'CLIENT_SECRET').first.value
    oauth_scope = ['https://www.googleapis.com/auth/drive', 'https://www.googleapis.com/auth/userinfo.profile']
    redirect_uri = Variable.where(key: 'REDIRECT_URI').first.value
    # Create a new API client & load the Google Drive API
    client = Google::APIClient.new(application_name: 'ppc-gd', application_version: PaperclipGoogleDrive::VERSION)
    drive = client.discovered_api('drive', 'v2')

    client.authorization.client_id = client_id
    client.authorization.client_secret = client_secret
    client.authorization.scope = oauth_scope
    client.authorization.redirect_uri = redirect_uri
    return nil if client_id.nil? || client_secret.nil? || redirect_uri.nil?
    # Request authorization
    x = Variable.new
    x.key = 'ACTIVATION_URL'
    x.value = client.authorization.authorization_uri.to_s
    x.save
    x = Variable.new
    x.key = 'AUTHORIZATION_CODE'
    x.save
  end

  def complete_activation
    client_id = Variable.where(key: 'CLIENT_ID').first.value
    client_secret = Variable.where(key: 'CLIENT_SECRET').first.value
    oauth_scope = ['https://www.googleapis.com/auth/drive', 'https://www.googleapis.com/auth/userinfo.profile']
    redirect_uri = Variable.where(key: 'REDIRECT_URI').first.value
    # Create a new API client & load the Google Drive API
    client = Google::APIClient.new(application_name: 'ppc-gd', application_version: PaperclipGoogleDrive::VERSION)
    drive = client.discovered_api('drive', 'v2')

    client.authorization.client_id = client_id
    client.authorization.client_secret = client_secret
    client.authorization.scope = oauth_scope
    client.authorization.redirect_uri = redirect_uri

    code = Variable.where(key: 'AUTHORIZATION_CODE').first.value
    client.authorization.code = code
    client.authorization.fetch_access_token!

    x = Variable.where(key: 'ACCESS_TOKEN').first
    if x.nil?
      x = Variable.new
      x.key = 'ACCESS_TOKEN'
    end
    x.value = client.authorization.access_token
    x.save

    y = Variable.where(key: 'REFRESH_TOKEN').first
    if y.nil?
      y = Variable.new
      y.key = 'REFRESH_TOKEN'
    end
    y.value = client.authorization.refresh_token
    y.save
    Variable.where(key: 'ACTIVATION_URL').first.delete
    Variable.where(key: 'AUTHORIZATION_CODE').first.delete
    exec('rails restart')
  end
end
