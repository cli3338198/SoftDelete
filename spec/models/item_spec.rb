require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'soft delete function' do
    it 'soft deletes an item' do
      item = Item.create(name: 'Test Item')
      item.soft_delete
      expect(item.deleted_at).to be_present
      expect(Item.count).to eq(0)
    end

    it 'restores a soft deleted item' do
      item = Item.create(name: 'Test Item')
      item.soft_delete
      item.restore
      expect(item.deleted_at).to be_nil
    end

    it 'excludes soft deleted items' do
      item = Item.create(name: 'Test item')
      soft_deleted_item = Item.create(name: 'Soft Deleted Test Item')
      expect(Item.count).to eq(2)
      soft_deleted_item.soft_delete

      items = Item.all
      expect(items).not_to include(soft_deleted_item)
      expect(Item.count).to eq(1)
    end

    it 'excludes soft deleted items from queries' do
      item = Item.create(name: 'Test item')
      item.soft_delete
      items = Item.all
      expect(items).not_to include(item)
    end

    it 'excludes soft deleted items from specific queries' do
      item = Item.create(name: 'Test item')
      soft_deleted_item = Item.create(name: 'Soft Deleted Test Item')
      soft_deleted_item.soft_delete

      items = Item.all
      expect(items).not_to include(soft_deleted_item)
    end
  end
end