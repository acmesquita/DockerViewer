require 'test_helper'

class ImageDockersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_docker = image_dockers(:one)
  end

  test "should get index" do
    get image_dockers_url
    assert_response :success
  end

  test "should get new" do
    get new_image_docker_url
    assert_response :success
  end

  test "should create image_docker" do
    assert_difference('ImageDocker.count') do
      post image_dockers_url, params: { image_docker: { created: @image_docker.created, image_id: @image_docker.image_id, repository: @image_docker.repository, size: @image_docker.size, tag: @image_docker.tag } }
    end

    assert_redirected_to image_docker_url(ImageDocker.last)
  end

  test "should show image_docker" do
    get image_docker_url(@image_docker)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_docker_url(@image_docker)
    assert_response :success
  end

  test "should update image_docker" do
    patch image_docker_url(@image_docker), params: { image_docker: { created: @image_docker.created, image_id: @image_docker.image_id, repository: @image_docker.repository, size: @image_docker.size, tag: @image_docker.tag } }
    assert_redirected_to image_docker_url(@image_docker)
  end

  test "should destroy image_docker" do
    assert_difference('ImageDocker.count', -1) do
      delete image_docker_url(@image_docker)
    end

    assert_redirected_to image_dockers_url
  end
end
