module Astor
  class Browser
    class << self
      def visit(node, level = 0)
        prepend = ("\t" * level * 2)

        if (node.respond_to?(:type))  
          result = prepend + "#{node.type}\n"

          if node.children.any?
            result += "<CHILDREN>\t"
            node.children.compact.each do |child|
              result += visit(child, level + 1)
            end
            result += "</CHILDREN>"
          end
        elsif node.is_a?(Array)
          result = prepend + node.join(", ")
        else
          result = prepend + "#{node}\n"
        end

        result
      end

      def browse(node)
        if node.type == :SCOPE
          display_scope(node)
        else
          display_children(node)
        end
      end

      def display_node(node)
        if node.respond_to?(:type)
          send("display_#{node.type.to_s.downcase}", node) 
        elsif node.is_a?(Array)
          node[0].to_s 
        else
          node.to_s
        end
      end

      def display_children(node)
        node.children.map { |x| display_node(x) }.compact.join(" ")
      end

      def display_array(node)
        "[#{display_children(node).strip}]"
      end

      def display_args(node)
        "(#{display_children(node)})"
      end

      def display_begin(node)
        "\n"
      end

      def display_block(node)
        ""
      end

      def display_call(node)
        "."
      end

      def display_list(node)
        node.children.compact.each do |child|
          browse(child)
        end
      end

      def display_class(node)
        "class #{display_children(node)}\nend"
      end
  
      def display_colon2(node)
        ""
      end

      def display_defn(node)
        "def #{display_children(node)}\nend"
      end

      def display_dstr(node)
        ""
      end

      def display_str(node)
        ""
      end

      def display_dvar(node)
        "DVAR"
      end

      def display_opcall(node)
        "= #{display_children(node)}"
      end

      def display_else(node)
        "else \n"
      end

      def display_evstr(node)
        "\#{"
      end

      def display_fcall(node)
        "..."
      end

      def display_if(node)
        "if "
      end

      def display_iter(node)
        "ITER"
      end

      def display_lasgn(node)
        # byebug
        # "#{display_node(node.children[0])} = #{display_node(node.children[1])}"
        display_children(node)
      end

      def display_lvar(node)
        "????"
      end

      def display_lit(node)
        display_children(node)
      end

      def display_module(node)
        "module "
      end
  
      def display_scope(node)
        children = node.children.select {|x| x.respond_to?(:children) }
        children.map {|x| display_node(x) }.join(" ")
      end
    
      def display_sclass(node)
        "class <<\n\nend"
      end

      def display_self(node)
        "self"
      end

      def display_vcall(node)
        display_children(node)
      end
    end
  end
end