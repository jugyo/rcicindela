# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/spec_helper'

describe RCicindela do
  it 'should create instance' do
    c = RCicindela.new('localhost', :port => 80, :base_path => '/cicindela/', :timeout => 10)
    c.host.should == 'localhost'
    c.port.should == 80
    c.base_path.should == '/cicindela'
    c.timeout.should == 10
  end

  describe 'Create instance with "http://localhost/cicindela" as base_uri' do
    before(:each) do
      @cicindela = RCicindela.new('localhost', :base_path => '/cicindela')
    end

    it 'call method "get" when call insert_pick' do
      @cicindela.should_receive(:request).with('record', {:op => 'insert_pick', :set => 'test', :user_id => 1, :item_id => 1})
      @cicindela.insert_pick(:set => 'test', :user_id => 1, :item_id => 1)
    end

    it 'call method "get" when call for_item' do
      @cicindela.should_receive(:request).with('recommend', {:op => 'for_item', :set => 'test', :item_id => 1})
      @cicindela.for_item(:set => 'test', :item_id => 1)
    end

    it 'call method "open" when call insert_pick' do
      @cicindela.should_receive(:get).
        with("/cicindela/record?item_id=1&op=insert_pick&set=test&user_id=1").and_return('result')
      result = @cicindela.insert_pick(:set => 'test', :user_id => 1, :item_id => 1)
      result.should == 'result'
    end

    it 'call method "open" when call for_item' do
      @cicindela.should_receive(:get).
        with("/cicindela/recommend?item_id=1&op=for_item&set=test").and_return('result')
      result = @cicindela.for_item(:set => 'test', :item_id => 1)
      result.should == 'result'
    end
  end

  describe 'Create instance with default option' do
    before(:each) do
      @cicindela = RCicindela.new(
        'localhost', :base_path => '/cicindela', :default_params => {:set => 'test', :user_id => 1})
    end

    it 'call method "get" when call insert_pick' do
      @cicindela.should_receive(:request).with('record', {:op => 'insert_pick', :item_id => 1})
      @cicindela.insert_pick(:item_id => 1)
    end

    it 'call method "open" when call insert_pick' do
      @cicindela.should_receive(:get).
        with("/cicindela/record?item_id=1&op=insert_pick&set=test&user_id=1").and_return('result')
      result = @cicindela.insert_pick(:item_id => 1)
      result.should == 'result'
    end
  end
end
