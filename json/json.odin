package json;

import "TreeSitter:parser"

foreign import external_json "json.lib"
@(default_calling_convention="c")
foreign external_json {

  tree_sitter_json :: proc () -> parser.Language ---;

}
