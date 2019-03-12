json.extract! container, :id, :container_id, :image, :command, :create, :status, :ports, :name, :created_at, :updated_at
json.url container_url(container, format: :json)
