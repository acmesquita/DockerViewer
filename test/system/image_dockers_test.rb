require "application_system_test_case"

class ImageDockersTest < ApplicationSystemTestCase
  setup do
    @image_docker = image_dockers(:one)
  end

  test "visiting the index" do
    visit image_dockers_url
    assert_selector "h1", text: "Image Dockers"
  end

  test "creating a Image docker" do
    visit image_dockers_url
    click_on "New Image Docker"

    fill_in "Created", with: @image_docker.created
    fill_in "Image", with: @image_docker.image_id
    fill_in "Repository", with: @image_docker.repository
    fill_in "Size", with: @image_docker.size
    fill_in "Tag", with: @image_docker.tag
    click_on "Create Image docker"

    assert_text "Image docker was successfully created"
    click_on "Back"
  end

  test "updating a Image docker" do
    visit image_dockers_url
    click_on "Edit", match: :first

    fill_in "Created", with: @image_docker.created
    fill_in "Image", with: @image_docker.image_id
    fill_in "Repository", with: @image_docker.repository
    fill_in "Size", with: @image_docker.size
    fill_in "Tag", with: @image_docker.tag
    click_on "Update Image docker"

    assert_text "Image docker was successfully updated"
    click_on "Back"
  end

  test "destroying a Image docker" do
    visit image_dockers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Image docker was successfully destroyed"
  end
end
