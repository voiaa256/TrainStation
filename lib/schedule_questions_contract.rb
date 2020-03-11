# frozen_string_literal: true

require 'dry-validation'
# checks data input
class SchedulesQuestionsContract < Dry::Validation::Contract
  params do
    required(:select_group).filled(:string)
    required(:select_teacher).value(:string)
  end
  rule(:select_group) do
    key.failure('Length is not correct') if value.length > 10
  end
  rule(:select_teacher) do
    key.failure('Week is not correct') if value.length > 20
  end
end
