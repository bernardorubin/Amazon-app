require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  def user
    @user ||= FactoryGirl.create(:user)
  end

  describe '#new' do
    context 'with no session' do
      it 'redirect to new session' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with session' do
      before do
        request.session[:user_id] = user.id
        get :new
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
      it 'assigns a product instance variable to a new Product' do
        expect(assigns(:product)).to be_a_new Product
      end
   end
  end

  describe '#create' do
    context 'without a signed in user' do
      it 'redirects to the sign in page' do
        post :create
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with a signed in user' do
      before { request.session[:user_id] = user.id }

      context 'with valid attributes' do
        it 'create a new product in the database' do
          count_before = Product.count
          post :create, params: { product: attributes_for(:product) }
          count_after = Product.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the product path" do
          post :create, params: { product: attributes_for(:product) }
          expect(response).to redirect_to(product_path(Product.last))
        end

        it 'associates the created product with the signed in user' do
          post :create, params: { product: attributes_for(:product) }
          expect(Product.last.user).to eq(user)
        end
      end
    context 'with invalid attributes' do
      it 'doesn\'t create a product in the database' do
        count_before = Product.count
        post :create, params: { product: {title: "", price:""} }
        count_after = Product.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        post :create, params: { product: {title: "", price:""} }
        expect(response).to render_template(:new)
      end
    end
    end
  end

  describe '#destroy' do
    context 'with no signed in user' do
      it 'redirects the user to the sign in page' do
        product = create(:product)
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with owner of product signed in' do
      before { request.session[:user_id] = user.id }

      it 'removes the record from the database' do
        product = create(:product, user: user)
        count_before = Product.count
        delete :destroy, params: { id: product.id }
        count_after = Product.count
        expect(count_before).to eq(count_after + 1)
      end
    end

    context 'with the non-owner of the product signed in' do
      before { request.session[:user_id] = user.id }

      it 'redirects to root path' do
        product = create(:product)
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to(root_path)
      end
    end



  end
  # to do:  tests for edit index update show
end
