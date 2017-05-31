require 'test_helper'

class SubItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_item = sub_items(:one)
  end

  test "should get index" do
    get sub_items_url
    assert_response :success
  end

  test "should get new" do
    get new_sub_item_url
    assert_response :success
  end

  test "should create sub_item" do
    assert_difference('SubItem.count') do
      post sub_items_url, params: { sub_item: { description: @sub_item.description, item_id: @sub_item.item_id, name: @sub_item.name, price: @sub_item.price } }
    end

    assert_redirected_to sub_item_url(SubItem.last)
  end

  test "should show sub_item" do
    get sub_item_url(@sub_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_sub_item_url(@sub_item)
    assert_response :success
  end

  test "should update sub_item" do
    patch sub_item_url(@sub_item), params: { sub_item: { description: @sub_item.description, item_id: @sub_item.item_id, name: @sub_item.name, price: @sub_item.price } }
    assert_redirected_to sub_item_url(@sub_item)
  end

  test "should destroy sub_item" do
    assert_difference('SubItem.count', -1) do
      delete sub_item_url(@sub_item)
    end

    assert_redirected_to sub_items_url
  end
end
