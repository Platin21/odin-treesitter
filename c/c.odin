package c;

import "TreeSitter:parser"

foreign import external_json "c.lib"
@(default_calling_convention="c")
foreign external_json {

  tree_sitter_c :: proc () -> parser.Language ---;

}
