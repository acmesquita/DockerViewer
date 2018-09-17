json.extract! image_docker, :id, :repository, :tag, :image_id, :created, :size, :created_at, :updated_at
json.url image_docker_url(image_docker, format: :json)
