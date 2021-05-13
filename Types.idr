module Types

import JSON
import Generics.Derive

%language ElabReflection

%default total

export
data PostType = Article | Other

%runElab derive "PostType" [Generic,Meta,Show,Eq,EnumToJSON,EnumFromJSON]

public export
record Post where
  constructor MkPost
  title : String
  text  : String
  date  : String
  type  : PostType

%runElab derive "Post" [Generic,Meta,Show,Eq,RecordToJSON,RecordFromJSON]

export
post : (String, String) -> Post
post (fn, ft) =
  MkPost fn ft "" Article

public export
data TemplateType = HBS | Unknown

%runElab derive "TemplateType" [Generic,Meta,Show,Eq,EnumToJSON,EnumFromJSON]

public export
record Template where
  constructor MkTemplate
  fname : String
  text  : String
  type  : TemplateType

%runElab derive "Template" [Generic,Meta,Show,Eq,RecordToJSON,RecordFromJSON]

export
template : (String, String) -> Template
template (fn, ft) =
  if isSuffixOf ".hbs" fn then
      let newFn = dropLast 4 fn
      in MkTemplate newFn ft HBS
    else MkTemplate fn ft Unknown
