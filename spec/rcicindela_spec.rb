# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/spec_helper'

describe RCicindela do
  it 'should create instance with base_uri' do
    uri = 'http://localhost/cicindela'
    c = RCicindela.new(uri)
    c.base_uri.should == uri
  end

  it 'should create instance with base_uri end "/"' do
    uri = 'http://localhost/cicindela/'
    c = RCicindela.new(uri)
    c.base_uri.should == 'http://localhost/cicindela'
  end

  it 'should create instance with base_uri end "///"' do
    uri = 'http://localhost/cicindela///'
    c = RCicindela.new(uri)
    c.base_uri.should == 'http://localhost/cicindela'
  end

  describe 'Create instance with "http://localhost/cicindela" as base_uri' do
    before(:each) do
      @cicindela = RCicindela.new('http://localhost/cicindela')
    end

    it 'call method "get" when call insert_pick' do
      @cicindela.should_receive(:get).with('record', {:op => 'insert_pick', :set => 'test', :user_id => 1, :item_id => 1})
      @cicindela.insert_pick(:set => 'test', :user_id => 1, :item_id => 1)
    end

    it 'call method "get" when call for_item' do
      @cicindela.should_receive(:get).with('recommend', {:op => 'for_item', :set => 'test', :item_id => 1})
      @cicindela.for_item(:set => 'test', :item_id => 1)
    end

    it 'call method "open" when call insert_pick' do
      @cicindela.should_receive(:open).
        with("http://localhost/cicindela/record?item_id=1&op=insert_pick&set=test&user_id=1").and_return(StringIO.new('result'))
      result = @cicindela.insert_pick(:set => 'test', :user_id => 1, :item_id => 1)
      result.should == 'result'
    end

    it 'call method "open" when call for_item' do
      @cicindela.should_receive(:open).
        with("http://localhost/cicindela/recommend?item_id=1&op=for_item&set=test").and_return(StringIO.new('result'))
      result = @cicindela.for_item(:set => 'test', :item_id => 1)
      result.should == 'result'
    end
  end

  describe 'Create instance with default option' do
    before(:each) do
      @cicindela = RCicindela.new('http://localhost/cicindela', :set => 'test', :user_id => 1)
    end

    it 'call method "get" when call insert_pick' do
      @cicindela.should_receive(:get).with('record', {:op => 'insert_pick', :item_id => 1})
      @cicindela.insert_pick(:item_id => 1)
    end

    it 'call method "open" when call insert_pick' do
      @cicindela.should_receive(:open).
        with("http://localhost/cicindela/record?item_id=1&op=insert_pick&set=test&user_id=1").and_return(StringIO.new('result'))
      result = @cicindela.insert_pick(:item_id => 1)
      result.should == 'result'
    end
  end
end
