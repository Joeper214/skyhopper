require_relative '../spec_helper'

describe CfTemplatePolicy do
  subject{described_class}

  %i[edit? update? destroy?].each do |action|
    permissions action do
      context 'when individual cf template' do
        let(:cft){build(:cf_template)}
        let(:infra){cft.infrastructure}
        let(:user){build(:user, master: false)}
        context 'when allow' do
          before{user.projects = [infra.project]}
          it 'grants' do
            is_expected.to permit(user, cft)
          end
        end
        context 'when not allow' do
          it 'denies' do
            is_expected.not_to permit(user, cft)
          end
        end
      end

      context 'when global cf template' do
        let(:master){build(:user, master: true,  admin: false)}
        let(:admin) {build(:user, master: false, admin: true)}
        let(:normal){build(:user, master: false, admin: false)}
        let(:strong){build(:user, master: true,  admin: true)}
        let(:cft){build(:cf_template, infrastructure: nil)}

        it 'grants only master and admin user' do
          is_expected.to     permit(strong, cft)
          is_expected.not_to permit(master, cft)
          is_expected.not_to permit(admin,  cft)
          is_expected.not_to permit(normal, cft)
        end
      end
    end
  end

  %i[new? create?].each do |action|
    permissions action do
      let(:master){build(:user, master: true,  admin: false)}
      let(:admin) {build(:user, master: false, admin: true)}
      let(:normal){build(:user, master: false, admin: false)}
      let(:strong){build(:user, master: true,  admin: true)}
      let(:cft){build(:cf_template)}

      it 'grants only master and admin user' do
        is_expected.to     permit(strong, cft)
        is_expected.not_to permit(master, cft)
        is_expected.not_to permit(admin,  cft)
        is_expected.not_to permit(normal, cft)
      end
    end
  end

  %i[new_for_creating_stack? insert_cf_params? create_and_send? history? show?].each do |action|
    permissions action do
      let(:cft){build(:cf_template)}
      let(:infra){cft.infrastructure}
      let(:user){build(:user, master: false)}
      context 'when allow' do
        before{user.projects = [infra.project]}
        it 'grants' do
          is_expected.to permit(user, cft)
        end
      end
      context 'when not allow' do
        it 'denies' do
          is_expected.not_to permit(user, cft)
        end
      end
    end
  end
end
