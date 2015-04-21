require 'spec_helper'

describe Oga::XML::Lexer do
  describe 'lexing <title> tags' do
    describe 'without <head> tags' do
      it 'wraps a <head> tag around a <title> tag' do
        lex_html('<title></title>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_NAME, 'title', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
        ]
      end

      it 'wraps a <head> tag around a <TITLE> tag' do
        lex_html('<TITLE></TITLE>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_NAME, 'TITLE', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
        ]
      end
    end

    describe 'without a <head> opening tag' do
      it 'adds the missing opening tag' do
        lex_html('<title></title></head>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_NAME, 'title', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
        ]
      end
    end

    describe 'without an <head> closing tag' do
      it 'adds the missing closing tag' do
        lex_html('<head><title></title>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_NAME, 'title', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
        ]
      end
    end
  end
end
