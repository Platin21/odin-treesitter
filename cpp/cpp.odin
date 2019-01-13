package cpp;

import "TreeSitter:parser"

foreign import external_json "cpp.lib"
@(default_calling_convention="c")
foreign external_json {

  tree_sitter_cpp :: proc () -> parser.Language ---;

}
