require "application_system_test_case"

class ContainersTest < ApplicationSystemTestCase
  setup do
    @container = containers(:one)
  end

  test "visiting the index" do
    visit containers_url
    assert_selector "h1", text: "Containers"
  end

  test "creating a Container" do
    visit containers_url
    click_on "New Container"

    fill_in "Command", with: @container.command
    fill_in "Container", with: @container.container_id
    fill_in "Create", with: @container.create
    fill_in "Image", with: @container.image
    fill_in "Name", with: @container.name
    fill_in "Ports", with: @container.ports
    fill_in "Status", with: @container.status
    click_on "Create Container"

    assert_text "Container was successfully created"
    click_on "Back"
  end

  test "updating a Container" do
    visit containers_url
    click_on "Edit", match: :first

    fill_in "Command", with: @container.command
    fill_in "Container", with: @container.container_id
    fill_in "Create", with: @container.create
    fill_in "Image", with: @container.image
    fill_in "Name", with: @container.name
    fill_in "Ports", with: @container.ports
    fill_in "Status", with: @container.status
    click_on "Update Container"

    assert_text "Container was successfully updated"
    click_on "Back"
  end

  test "destroying a Container" do
    visit containers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Container was successfully destroyed"
  end
end
