require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  test "should get a list of categories" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should show the requested category" do
    category_id = categories(:one).id
    get :show, id: category_id
    assert_response :success
    assert_template :show
    assert_equal assigns(:category), categories(:one)
  end

  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, { provider: "github" }
  end

  test "should get the new form when creating a new category" do
    session[:merchant_id] = merchants(:one).id
    get :new
    assert_response :success
    assert_template :new

    category = assigns(:category)
    assert_not_nil category
    assert_nil category.name
  end




end
