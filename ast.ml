type op = 
  Add | Sub | Mul | Div | Equal | Neq 
| Less | Leq | Greater | Geq | And | Or
| Member

type uop = Neg

type prim_typ = Int | Bool | Real | Char

(* Maybe we should fuse prim_typ into typ *)
type typ = 
  | Set of typ 
  | Map of typ * typ
  | Tuple of typ list 
  | Array of typ
  | String
  | Func of typ * typ (* typ1: args, typ2: output *)
  | PrimTyp of prim_typ

type expr =
  | Id of string
  | Binop of expr * op * expr
  | Uniop of uop * expr
  | Lit of int
  | RealLit of float
  | BoolLit of bool
  | CharLit of char
  | StringLit of string
  | InterStringLit of string list * expr list
  | TupleLit of expr list
  | SetLit of expr list
  | ArrayLit of expr list
  | ArrayRange of expr * expr option * expr
  | ArrayGet of string * expr
  | ArrayAt of string * expr * expr
  (* Both expr could be optional *)
  | SetBuilder of expr option * stmt * expr
  | AggAccessor of expr * expr
  | FuncDefNamed of string * string list * stmt list (* name * param ids * function body *)
  | FuncCall of string * expr
  (* | Seq of expr * expr  *)

and stmt =
  | Asn of string list * expr
  | Decl of string * typ
  | AsnDecl of string list * expr
  | Expr of expr
  | Iter of string list * expr
  | If of expr * stmt list * stmt list
  | While of expr * stmt list
  | For of string * expr * stmt list

type program = stmt list
(* TODO: op for `(...)` (PARAMS) *)
