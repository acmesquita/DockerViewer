json.extract! server, :id, :name, :ip, :chave_ssh, :login, :created_at, :updated_at
json.url server_url(server, format: :json)
