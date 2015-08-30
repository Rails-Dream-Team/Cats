require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  def setup
    @board = boards(:one)
    @topic1 = topics(:one)
    @topic2 = topics(:two)
    @topic3 = topics(:three)
    @all_topics = [@topic1, @topic2, @topic3]
    @admin = users(:admin)
    @volunteer = users(:volunteer)
    @basic = users(:basic)
  end

  class TopicsWhenAdmin < TopicsControllerTest
    def setup
      super
      sign_in @admin
    end

    test "get index renders html" do
      get :index
      assert_equal @all_topics, assigns(:topics)
      assert_template :index
    end

    test "get new renders html" do
      get :new
      assert_instance_of Topic, assigns(:topic)
      assert_template :new
    end

    test "get edit renders html" do
      get :edit, id: @topic1.id
      assert_template :edit
    end

    test "get show renders html" do
      get :show, id: @topic1.id
      assert_template :show
    end
  end # end of TopicsWhenAdmin

  class TopicsWhenVolunteer < TopicsControllerTest
    def setup
      super
      sign_in @volunteer
    end

    test "get index renders html" do
      get :index
      assert_equal @all_topics, assigns(:topics)
      assert_template :index
    end

    test "get new renders html" do
      get :new
      assert_instance_of Topic, assigns(:topic)
      assert_template :new
    end

    test "get edit renders html if created by current user" do
      get :edit, id: @topic2.id
      assert_equal @volunteer, @topic2.user
      assert_template :edit
    end

    test "get edit redirects if created by different user" do
      get :edit, id: @topic1.id
      refute @volunteer == @topic1.user
      assert_redirected_to(request.referrer || root_path)
    end

    test "get show renders html" do
      get :show, id: @topic1.id
      assert_template :show
    end
  end # end of TopicsWhenVolunteer

  class TopicsWhenBasic < TopicsControllerTest
    def setup
      super
      sign_in @basic
    end

    test "get index renders html" do
      get :index
      assert_equal @all_topics, assigns(:topics)
      assert_template :index
    end

    test "get new renders html" do
      get :new
      assert_instance_of Topic, assigns(:topic)
      assert_template :new
    end

    test "get edit renders html if created by current user" do
      get :edit, id: @topic3.id
      assert_equal @basic, @topic3.user
      assert_template :edit
    end

    test "get edit redirects if created by different user" do
      get :edit, id: @topic1.id
      refute @basic == @topic1.user
      assert_redirected_to(request.referrer || root_path)
    end

    test "get show renders html" do
      get :show, id: @topic1.id
      assert_template :show
    end
  end # end of TopicsWhenBasic

  class TopicsCreate < TopicsControllerTest
    def setup
      super
      sign_in @admin
    end

    test 'admin creates with valid attributes and redirects' do
      assert_difference('Topic.count', 1) do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: @board }
      end
      assert_redirected_to topic_path(assigns(:topic))
    end

    test 'admin renders new with invalid attribute submission (no title)' do
      assert_no_difference('Topic.count') do
        post :create, topic: { title: '', board_id: @board }
      end
      assert_template :new
    end

    test 'admin renders new with invalid attribute submission (no board)' do
      assert_no_difference('Topic.count') do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: nil }
      end
      assert_template :new
    end

    test 'volunteer creates with valid attributes and redirects' do
      sign_in @volunteer
      assert_difference('Topic.count', 1) do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: @board }
      end
      assert_redirected_to topic_path(assigns(:topic))
    end

    test 'basic creates with valid attributes and redirects' do
      sign_in @basic
      assert_difference('Topic.count', 1) do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: @board }
      end
      assert_redirected_to topic_path(assigns(:topic))
    end
  end # end of TopicsCreate

  class TopicsUpdate < TopicsControllerTest
    def setup
      super
      sign_in @admin
    end

    test 'admin updates with valid attributes and redirects' do
      old_title = @topic1.title
      new_title = 'fake title, now with more fake'
      patch :update, id: @topic1, topic: { title: new_title }
      @topic1.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_title, @topic1.title
    end

    test 'admin renders edit with invalid attribute submission (no title)' do
      old_title = @topic1.title
      patch :update, id: @topic1, topic: { title: nil }
      @topic1.reload
      assert_equal old_title, @topic1.title
      assert_template :edit
    end

    test 'admin renders edit with invalid attribute submission (no board)' do
      old_board = @topic1.board
      patch :update, id: @topic1, topic: { board_id: nil }
      @topic1.reload
      assert_equal old_board, @topic1.board
      assert_template :edit
    end

    test 'volunteer updates with valid attr if created by current user' do
      sign_in @volunteer
      assert_equal @volunteer, @topic2.user
      old_title = @topic2.title
      new_title = 'fake title, now with more fake'
      patch :update, id: @topic2, topic: { title: new_title }
      @topic2.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_title, @topic2.title
    end

    test 'volunteer redirects if created by different user' do
      sign_in @volunteer
      refute @volunteer == @topic1.user
      old_title = @topic1.title
      new_title = 'fake title, now with more fake'
      patch :update, id: @topic1, topic: { title: new_title }
      @topic1.reload
      assert_equal old_title, @topic1.title
      assert_redirected_to(request.referrer || root_path)
    end

    test 'basic updates with valid attr if created by current user' do
      sign_in @basic
      assert_equal @basic, @topic3.user
      old_title = @topic3.title
      new_title = 'fake title, now with more fake'
      patch :update, id: @topic3, topic: { title: new_title }
      @topic3.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_title, @topic3.title
    end

    test 'basic redirects if created by different user' do
      sign_in @basic
      refute @basic == @topic1.user
      old_title = @topic1.title
      new_title = 'fake title, now with more fake'
      patch :update, id: @topic1, topic: { title: new_title }
      @topic1.reload
      assert_equal old_title, @topic1.title
      assert_redirected_to(request.referrer || root_path)
    end
  end # end of TopicsUpdate

  class TopicsDelete < TopicsControllerTest
    test 'admin soft deletes and redirects' do
      sign_in @admin
      old_unscoped = Topic.unscoped.count
      assert_difference('Topic.count', -1) do
        delete :destroy, id: @topic1
      end
      @topic1.reload
      assert_redirected_to topics_path
      assert_equal old_unscoped, Topic.unscoped.count
      refute @topic1.deleted_at.nil?
    end

    test 'volunteer redirects and does not delete' do
      sign_in @volunteer
      old_deleted_at = @topic1.deleted_at
      assert_no_difference('Topic.count') do
        delete :destroy, id: @topic1
      end
      @topic1.reload
      assert_equal old_deleted_at, @topic1.deleted_at, 'volunteer should not delete'
      assert_redirected_to(request.referrer || root_path)
    end

    test 'basic redirects and does not delete' do
      sign_in @basic
      old_deleted_at = @topic1.deleted_at
      assert_no_difference('Topic.count') do
        delete :destroy, id: @topic1
      end
      @topic1.reload
      assert_equal old_deleted_at, @topic1.deleted_at, 'basic should not delete'
      assert_redirected_to(request.referrer || root_path)
    end
  end # end of TopicsDelete

  class TopicsWhenLoggedOut < TopicsControllerTest
    test "get index redirects" do
      get :index
      assert_redirected_to new_user_session_path
    end

    test "get new redirects" do
      get :new
      assert_redirected_to new_user_session_path
    end

    test "get edit redirects" do
      get :edit, id: @topic1.id
      assert_redirected_to new_user_session_path
    end

    test "get show redirects" do
      get :show, id: @topic1.id
      assert_redirected_to new_user_session_path
    end

    test 'post create redirects' do
      assert_no_difference('Topic.count') do
        post :create, topic: { title: 'fake topic, being all fake and whatnot' }
      end
      assert_redirected_to new_user_session_path
    end

    test 'patch update redirects' do
      sign_out @admin
      old_title = @topic1.title
      patch :update, id: @topic1, topic: { title: 'fake topic, being all fake and whatnot' }
      assert_redirected_to new_user_session_path
      assert_equal old_title, @topic1.title
    end

    test 'delete destroy redirects' do
      old_deleted_at = @topic1.deleted_at
      assert_no_difference('Topic.count') do
        delete :destroy, id: @topic1
      end
      @topic1.reload
      assert_redirected_to new_user_session_path
      assert_equal old_deleted_at, @topic1.deleted_at
    end
  end # end of TopicsWhenLoggedOut
end
