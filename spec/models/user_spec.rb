require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'Uniqueness validation of ascii character' do
    before { User.create(name_a: 'A', name_b: 'A', name_c: 'A') }

    it do
      expect { User.create(name_a: 'a') }.not_to raise_error
      expect { User.create(name_b: 'a') }.to raise_error ActiveRecord::RecordNotUnique
      expect { User.create(name_c: 'a') }.to raise_error ActiveRecord::RecordNotUnique
    end
  end

  describe 'Uniqueness validation of non-ascii character' do
    describe 'Japanese' do
      before { User.create(name_a: 'ハ', name_b: 'ハ', name_c: 'ハ') }

      it do
        expect { User.create(name_a: 'パ') }.not_to raise_error
        expect { User.create(name_b: 'パ') }.not_to raise_error
        expect { User.create(name_c: 'パ') }.to raise_error ActiveRecord::RecordNotUnique
      end
    end

    describe 'Emoji' do
      before { User.create(name_a: '🍣', name_b: '🍣', name_c: '🍣') }

      it do
        expect { User.create(name_a: '🍻') }.not_to raise_error
        expect { User.create(name_b: '🍻') }.to raise_error ActiveRecord::RecordNotUnique
        expect { User.create(name_c: '🍻') }.to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end

  describe 'select record' do
    before { User.create(name_a: 'Abc', name_b: 'aBc', name_c: 'abC') }

    it do
      expect(User.find_by(name_a: 'aBC')).to eq nil
      expect(User.find_by(name_b: 'AbC').name_b).to eq 'aBc'
      expect(User.find_by(name_c: 'ABc').name_c).to eq 'abC'
    end
  end
end
