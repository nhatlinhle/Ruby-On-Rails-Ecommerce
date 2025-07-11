module ApplicationHelper
  def paginate(collection, params: {})
    render partial: "admin/shared/pagination", locals: { collection: collection, params: params }
  end
end
