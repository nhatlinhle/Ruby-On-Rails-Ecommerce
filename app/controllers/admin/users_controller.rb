class Admin::UsersController < Admin::BaseController
  layout "admin"

  def index
    name = params[:name]
    email = params[:email]

    @users = User.all
    @users = @users.where("name LIKE :name", { name:  "%#{name}%" }) if name
    @users = @users.where("email LIKE :email", { email: "%#{email}%" }) if email
    @users = @users.order(id: :asc)
    @users = @users.page(params[:page]).per(20)

    render "admin/users/index"
  end

  def new
    @form = ::UserForms::CreateUserForm.new(
      name: nil,
      email: nil,
      phone_number: nil,
      birth_day: nil,
      address: nil
    )
  end

  def create
    @form = ::UserForms::CreateUserForm.new(user_params_create)
    if @form.save
      flash.now[:error] = "User created successfully!"
      redirect_to admin_users_path
    else
      flash.now[:error] = "User creation failed!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    id = params[:id]
    @user = User.find(id)

    @form = ::UserForms::UpdateUserForm.new(
      user: @user,
      name: @user.name,
      email: @user.email,
      phone_number: @user.phone_number,
      birth_day: @user.birth_day,
      address: @user.address
    )
  end

  def update
    @user = User.find(params[:id])
    @form = ::UserForms::UpdateUserForm.new(user_params_update.merge(user: @user))

      if @form.update
        flash[:success] = "Update success!"
        redirect_to admin_users_path
      else
        flash[:error] = "Update failed!"
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @user = User.find(params[:id])

    if @user == current_user
      flash[:error] = "You cannot delete yourself while logged in!"
      redirect_to admin_users_path
      return
    end

    @user.destroy
    flash[:success] = "User deleted successfully!"
    redirect_to admin_users_path
  end

  def user_params_update
    params.require(:user_forms_update_user_form).permit(
      :name, :email, :phone_number, :birth_day, :address, :avatar
    )
  end

  def user_params_create
    params.require(:user_forms_create_user_form).permit(
      :name, :email, :phone_number, :birth_day, :address, :avatar
    )
  end
end
