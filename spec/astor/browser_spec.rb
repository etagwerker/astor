require "spec_helper"

RSpec.describe Astor::Browser do
  describe "browse" do
    context "simple assignments" do
      let(:result) { "y = 1" }

      it "displays a simple AST" do
        node = RubyVM::AbstractSyntaxTree.parse("y = 1")
        displayed = Astor::Browser.browse(node)
        expect(displayed).to eq(result)
      end
    end
    
    context "simple assignment with formula" do
      let(:result) { "y = x + 1" }

      it "displays a simple AST" do
        node = RubyVM::AbstractSyntaxTree.parse("y = x + 1")
        displayed = Astor::Browser.browse(node)
        expect(displayed).to eq(result)
      end
    end
  end

  describe "visit" do
    context "when assignment is simple" do
      it "displays all types" do
        node = RubyVM::AbstractSyntaxTree.parse("y = 1")
        visited = Astor::Browser.visit(node)
        expect(visited).to eq("SCOPEyLASGNyLIT1")
      end
    end

    context "when assignment is complex" do
      it "displays all types" do
        node = RubyVM::AbstractSyntaxTree.parse("y = x + 1")
        visited = Astor::Browser.visit(node)
        expect(visited).to eq("SCOPEyLASGNyOPCALLVCALLx+LISTLIT1")
      end
    end
  end
end
