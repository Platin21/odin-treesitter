package parser;

FILE :: opaque rawptr;
Symbol :: distinct u16;
Language :: opaque rawptr;
Parser :: opaque rawptr;
Tree :: opaque rawptr;

InputEncoding :: enum u32 {
  UTF8 = 0,
  UTF16 = 1
};

SymbolType :: enum u32 {
  Regular,
  Anonymous,
  Auxiliary
};

Point :: struct {
  row : u32,
  column : u32,
};

Range :: struct {
  start_point: Point,
  end_point: Point,
  start_byte: u32,
  end_byte: u32,
};

Byte_Index :: distinct u32;

Input :: struct {
  payload: rawptr,
  encoding: InputEncoding,
  read : #type proc "c" (payload: rawptr, byte_index: i32, position: Point, bytes_read: ^u8) -> cstring,
};

LogType :: enum u32  {
  Parse = 0,
  Lex = 1,
};

Logger :: struct {
  payload: rawptr,
  log: #type proc "c" (payload: rawptr, logType: LogType, arg2: cstring),
};

InputEdit :: struct {
  start_byte: u32,
  old_end_byte: u32,
  new_end_byte: u32,
  start_point: Point,
  old_end_point: Point,
  new_end_point: Point,
};

Node :: struct  #packed {
  ctx: [4]u32,
  id: rawptr,
  tree: Tree,
};

TreeCursor :: struct {
  ctx: [2]u32,
  id: rawptr,
  tree: rawptr,
};

foreign import treeSitter "runtime.lib"
@(default_calling_convention="c",link_prefix="ts_")
foreign treeSitter {
parser_new :: proc() -> Parser ---;
parser_delete :: proc(parser: Parser) ---;
parser_language :: proc (parser: Parser) -> Language ---;
parser_set_language :: proc(parser: Parser, arg2: Language) -> bool ---;
parser_logger :: proc(parser: Parser) -> ^Logger ---;
parser_set_logger :: proc (parser: Parser, arg2: Logger) ---;
parser_print_dot_graphs :: proc (parser: Parser, arg2: FILE) ---; // changed
parser_halt_on_error :: proc (parser: Parser, arg2: bool) ---;
parser_parse :: proc (parser: Parser, tree: Tree, arg3: Input) -> Tree ---;
parser_parse_string :: proc (parser: Parser, tree: Tree, arg3: cstring, arg4: u32) -> Tree ---;
parser_enabled :: proc (parser: Parser) -> bool ---;
parser_set_enabled :: proc (parser: Parser, enable: bool) ---;
parser_set_operation_limit :: proc (parser: Parser, arg2: u64) ---;
parser_reset :: proc (parser: Parser) ---;
parser_set_included_ranges :: proc (parser: Parser, arg2: ^Range, arg3: u32) ---;
parser_included_ranges :: proc (parser: Parser, arg2: ^u32) -> ^Range ---;

tree_copy :: proc (tree: Tree) -> Tree ---;
tree_delete :: proc (tree: Tree) ---;
tree_root_node :: proc (tree: Tree) -> Node ---;
tree_edit :: proc (tree: Tree,arg2: ^InputEdit) ---;
tree_get_changed_ranges :: proc (tree: Tree,arg2: Tree, arg3: ^u32) -> Range ---;
tree_print_dot_graph :: proc (tree: Tree, arg2: FILE) ---;
tree_language :: proc (tree: Tree) -> Language ---;
tree_cursor_new :: proc(tree: Node) -> TreeCursor ---;
tree_cursor_delete :: proc (treeCursor: TreeCursor) ---;
tree_cursor_goto_first_child :: proc(treeCursor: TreeCursor) -> bool ---;
tree_cursor_goto_first_child_for_byte :: proc(treeCursor: TreeCursor, arg2: u32) -> i64 ---;
tree_cursor_goto_next_sibling :: proc (treeCursor: TreeCursor) -> bool ---;
tree_cursor_goto_parent :: proc (treeCursor: TreeCursor) -> bool ---;
tree_cursor_current_node :: proc (treeCursor: TreeCursor) -> Node ---;

node_start_byte :: proc (node: Node) -> u32 ---;
node_start_point :: proc (node: Node) -> Point ---;
node_end_byte :: proc (node: Node) -> u32 ---;
node_end_point :: proc (node: Node) -> Point ---;
node_symbol :: proc (node: Node) -> Symbol ---;
node_type :: proc (node: Node) -> cstring ---;
node_string :: proc (node: Node) -> cstring ---;
node_equal :: proc(rhs: Node, lhs: Node) -> bool ---;
node_is_null :: proc (node: Node) -> bool ---;
node_is_named :: proc (node: Node) -> bool ---;
node_is_missing :: proc (node: Node) -> bool ---;
node_has_changes :: proc (node: Node) -> bool ---;
node_has_error  :: proc (node: Node) -> bool ---;
node_parent :: proc (node: Node) -> Node ---;
node_child :: proc (node: Node, arg2: u32) -> Node ---;
node_name_child :: proc (node: Node, arg2: u32) -> Node ---;
node_child_count :: proc (node: Node) -> u32 ---;
node_named_child_count :: proc  (node: Node) -> u32 ---;
node_next_sibling :: proc (node: Node) -> Node ---;
node_next_named_sibling  :: proc (node: Node) -> Node ---;
node_prev_named_sibling :: proc (node: Node) -> Node ---;
node_first_child_for_byte :: proc (node: Node, arg2: u32) -> Node ---;
node_frist_named_child_for_byte :: proc (node: Node, arg2: u32) -> Node ---;
node_descendant_for_byte_range :: proc (node: Node, arg2: u32, arg3: u32) -> Node ---;
node_named_descendant_for_byte_range :: proc (node: Node, arg2: u32, arg3: u32) -> Node ---;
node_descendant_for_point_range :: proc (node: Node, arg2: Point, arg3: Point) -> Node ---;
node_named_descendant_for_point_range :: proc (node: Node,arg2: Point,arg3: Point) -> Node ---;
node_edit :: proc (node: ^Node, arg2: ^InputEdit) ---;

language_symbol_count :: proc(language: Language) -> u32 ---;
language_symbol_name :: proc( language: Language, arg2: Symbol) -> cstring ---;
language_symbol_for_name :: proc(language: Language, arg2: cstring) -> Symbol ---;
language_symbol_type :: proc(language: Language, arg2: Symbol) -> SymbolType ---;
language_version :: proc(language: Language) -> u32 ---;
}

TREE_SITTER_LANGUAGE_VERSION :: 9;
