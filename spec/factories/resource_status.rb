#
# Copyright (c) 2013-2015 SKYARCH NETWORKS INC.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

FactoryGirl.define do
  factory :resource_status do
    resource
    kind 'cook'
    value 'Success'
  end
end
