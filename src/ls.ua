┌─╴LsCommand
  ~ "./lib/args.ua" ~ Command CommandDef

  LsDef ← CommandDef CommandDef!(
    OptionDef!([
        OptionDef OptType~Boolean {@a "--all"}
      ])
    ArgDef!([Rest])
  )

  Parse ← CommandDef~Parse LsDef

  PathArgs ← ◇Command~Arg~Rest~Values ⊡0 Command~Args
└─╴

┌─╴DirectoryFinder
  ~File {Path IsFile}
  ~Dir {Path Files}
  ~Error {Source Message}
  ~Result {Dirs ← {}|Errors ← {}}

  # File ? Path
  MkFile ↚ (
    File⟜&fif
  )

  # Result ? Result Dir
  SearchDir ↚ (
    ⍣(⍩(⍜Result~Dirs(⊂) ⊙(□Dir)) ⊙⊙⍚MkFile ⊙⟜&fld
    | ⍜Result~Errors(⊂) ⊙(□Error))
  )

  # Result ? Paths
  Search ← (
    ⊙Result
    ∧(˜SearchDir °□)
  )
└─╴

# Basename ? Path
Basename ← (
  regex "^.*\\/(.+$)"

  °□⊡0_1
)

LsCommand~Parse &args

DirectoryFinder~Search ⍥(["."]◌) ⊸≍[] ⊸LsCommand~PathArgs

⍚(&ep ˜⍜°$"_: _"(⊃⋅⋅∘⋅⊙◌) °DirectoryFinder~Error) ⊸DirectoryFinder~Result~Errors

DirectoryFinder~Result~Dirs
⟜(⍚⨬("\n"|"") ≡≍0 ⇌⇡⧻)

⍚(
  &p ":" &pf °DirectoryFinder~Dir
  ⍚(&pf " " &pf Basename DirectoryFinder~File~Path)
  &p
)

◌
