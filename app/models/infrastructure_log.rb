#
# Copyright (c) 2013-2015 SKYARCH NETWORKS INC.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class InfrastructureLog < ActiveRecord::Base
  belongs_to :infrastructure
  belongs_to :user

  scope :check_security_update, -> { where('details LIKE ?', '%check security%finished%') }

  class << self
    def for_infra(infra_id)
      where(infra_id).includes(:user).order("created_at DESC")
    end

    # define success and fail
    [:success, :fail].each do |name|
      define_method(name, -> (infrastructure_id: , details: , user_id: ) {
        begin
          create(
            status:            name == :success,
            details:           details,
            infrastructure_id: infrastructure_id,
            user_id:           user_id
          )
        rescue ::ActiveRecord::StatementInvalid => ex
          if ex.message.include?("Data too long")

            sliced = details.byteslice(0, 16000000).chop

            log = create(
              status:            name == :success,
              details:           sliced,
              infrastructure_id: infrastructure_id,
              user_id:           user_id
            )
            log.save!

            dest = File::join(AppSetting.get.log_directory, "infralog_#{log.id}.log")
            log.details = "This log is too long. Full log is in \"#{dest}\"\n" + sliced

            File.open(dest, 'w') do |of|
              of.write(details)
            end

            log.save!
          end
        end
      })
    end
  end
end
