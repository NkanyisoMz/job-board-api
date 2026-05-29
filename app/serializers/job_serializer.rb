class JobSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :company_name,
    :location,
    :description,
    :employment_type,
    :experience_level,
    :remote,
    :salary_range,
    :created_at
  )

  belongs_to :user
end
